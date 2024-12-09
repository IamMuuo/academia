import 'package:academia/features/auth/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/auth/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository _userRepository = UserRepository();

  // Load the cached user information
  AuthCubit() : super(AuthInitialState()) {
    _userRepository.fetchAllUsersFromCache().then((value) {
      value.fold((error) {
        emit(AuthErrorState(error));
      }, (users) {
        emit(AuthCachedUsersRetrieved(cachedUsers: users));
      });
    });
  }
}
