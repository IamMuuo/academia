import 'package:academia/database/database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/auth/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AppDatabase appDatabase;
  AuthCubit(this.appDatabase) : super(AuthInitialState()) {
    _loadStoredUser();
  }

  Future<void> _loadStoredUser() async {
    try {
      final allUsers = await appDatabase.select(appDatabase.user).get();
      print(allUsers);
      if (allUsers.isEmpty) {
        emit(UnAuthenticatedState());
      }
      emit(AuthenticatedState(user: allUsers.first));
    } catch (e) {
      rethrow;
      // emit(AuthErrorState("Error: $e"));
    }
  }
}
