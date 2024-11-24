import 'package:academia/database/database.dart';
import 'package:academia/utils/network/dio_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/auth/cubit/auth_states.dart';
import 'package:intl/intl.dart';
import 'package:magnet/magnet.dart';

class AuthCubit extends Cubit<AuthState> {
  final AppDatabase appDatabase;
  AuthCubit(this.appDatabase) : super(AuthInitialState()) {
    _loadStoredUser().then((val) {});
  }

  Future<void> _loadStoredUser() async {
    try {
      final allUsers = await appDatabase.select(appDatabase.user).get();
      if (allUsers.isEmpty) {
        emit(AuthFirstAppLaunch());
        return;
      }
      emit(AuthCachedUsersRetrieved(cachedUsers: allUsers));
    } catch (e) {
      emit(AuthErrorState(e.toString()));
      rethrow;
    }
  }

  /// Authenticates a user
  Future<Either<String, UserData>> authenticate(
      UserCredentialData creds) async {
    emit(AuthLoadingState());
    final result = await _fetchUserDataFromMagnet(
      creds.admno,
      creds.password,
    );

    return result.fold((l) {
      emit(AuthErrorState(l));
      return left(l);
    }, (r) async {
      // print(r.toJson());

      // authenticate with verisafe
      final response = await _authenticateWithVerisafe(creds);
      return response.fold((l) {
        emit(PartiallyAuthenticatedState(user: r));
        return left(l);
      }, (r) async {
        /// Write the user data
        await appDatabase
            .into(appDatabase.user)
            .insertOnConflictUpdate(r.toCompanion(true));

        final credentials = UserCredentialData(
          userId: r.id,
          username: r.username,
          email: r.email!,
          admno: creds.admno,
          password: creds.password,
          lastLogin: DateTime.now(),
        );

        /// Write the credential data
        await appDatabase
            .into(appDatabase.userCredential)
            .insertOnConflictUpdate(credentials);

        // emit the fully autheticated state
        emit(FullyAuthenticatedState(user: r, creds: credentials));

        return right(r);
      });
      // emit the authenticated state
    });
  }

  Future<Either<String, UserData>> _authenticateWithVerisafe(
      UserCredentialData creds) async {
    final DioClient dioClient = DioClient(
      creds: creds,
      database: appDatabase,
    );

    try {
      final response = await dioClient.dio.post(
        "/auth/authenticate",
        data: {
          "admission_number": creds.admno,
          "password": creds.password,
        },
      );

      if (response.statusCode == 200) {
        return right(UserData.fromJson(response.data));
      }

      return left(response.data["error"]);
    } on DioException catch (e) {
      return left(e.toString());
    } catch (e) {
      return left(e.toString());
    }
  }

  Future<Either<String, UserData>> _fetchUserDataFromMagnet(
      String admno, String password) async {
    final Magnet magnet = Magnet(
      admno,
      password,
    );

    final loginRes = await magnet.login();

    return loginRes.fold((l) {
      return left(l.toString());
    }, (r) async {
      final data = await magnet.fetchUserDetails();

      return data.fold((l) {
        return left(l.toString());
      }, (r) {
        var dOB = DateFormat('MM/dd/yyyy').parse(r["dateofbirth"] ?? "");
        String name = r['name'] ?? "";
        List<String> nameParts = name.split(' ');
        String firstName = nameParts.first;
        String lastName = nameParts.sublist(1).join(' ');

        final userData = UserData(
          id: "",
          username: "",
          firstname: firstName,
          othernames: lastName,
          phone: "",
          email: r["email"] ?? "",
          gender: r["gender"] ?? "",
          nationalId: r["idno"] ?? "",
          active: (r["academicstatus"] ?? "true") == "true" ? true : false,
          modifiedAt: DateTime.now(),
          dateOfBirth: dOB,
          createdAt: DateTime.now(),
        );
        return right(userData);
      });
    });
  }
}
