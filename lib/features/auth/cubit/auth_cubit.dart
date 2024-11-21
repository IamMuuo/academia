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
    }
  }

  Future<Either<String, UserData>> fetchUserDataFromMagnet(
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
        );
        return right(userData);
      });
    });
  }
}
