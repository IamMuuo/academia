import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
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
      String admno, String password) async {
    emit(AuthLoadingState());
    final result = await _fetchUserDataFromMagnet(admno, password);

    return result.fold((l) {
      emit(AuthErrorState(l));
      return left(l);
    }, (r) async {
      print(r.toJson());
      // await appDatabase
      //     .into(appDatabase.user)
      //     .insertOnConflictUpdate(r.toCompanion(true));

      // emit the authenticated state
      emit(PartiallyAuthenticatedState(user: r));
      return right(r);
    });
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
