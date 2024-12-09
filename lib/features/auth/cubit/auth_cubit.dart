import 'package:academia/database/database.dart';
import 'package:academia/features/auth/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/auth/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository _userRepository = UserRepository();

  // Load the cached user information
  AuthCubit() : super(AuthInitialState()) {
    _userRepository.fetchAllUsersFromCache().then(
      (value) {
        value.fold((error) {
          emit(AuthErrorState(error));
        }, (users) {
          if (users.isEmpty) {
            emit(AuthFirstAppLaunch());
            return;
          }
          emit(AuthCachedUsersRetrieved(cachedUsers: users));
        });
      },
    );
  }

  /// Authenticate performs authentication mechanisms with both verisafe
  /// and magnet to authenticate a user
  Future<Either<String, bool>> authenticate(
      UserCredentialData credentials) async {
    emit(AuthLoadingState());
    final result = await _userRepository.authenticateRemotely(credentials);

    if (result.isLeft()) {
      emit(AuthErrorState((result as Left).value));
      return left((result as Left).value);
    }

    emit(AuthenticatedState(user: (result as Right).value));
    return right(true);
  }
}
