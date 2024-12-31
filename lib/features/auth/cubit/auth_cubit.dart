import 'dart:async';

import 'package:academia/database/database.dart';
import 'package:academia/features/auth/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:academia/features/auth/cubit/auth_states.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// TODO: erick figure out a way to automatically log in user when connection is established
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
            return null;
          } else if (users.length == 1) {
            return fetchUserCredsFromCache(users.first).then((result) {
              result.fold((error) {
                emit(AuthErrorState(error));
                return;
              }, (creds) async {
                final List<ConnectivityResult> connectivityResult =
                    await (Connectivity().checkConnectivity());

                // Authenticate locally if no internet connection was found
                if (connectivityResult.contains(ConnectivityResult.none)) {
                  emit(AuthenticatedState(user: users.first, localAuth: true));
                  return;
                }

                authenticate(creds).then((auth) {
                  auth.fold((error) {
                    emit(AuthErrorState(error));
                    return;
                  }, (r) {
                    AuthenticatedState(user: users.first);
                    return;
                  });
                });
              });
            });
          }
          emit(AuthCachedUsersRetrieved(cachedUsers: users));
        });
      },
    );
  }

  /// Authenticate performs authentication mechanisms with both verisafe
  /// and magnet to authenticate a user
  Future<Either<String, bool>> authenticate(
    UserCredentialData credentials,
  ) async {
    emit(AuthLoadingState());
    final result = await _userRepository.authenticateRemotely(credentials);

    if (result.isLeft()) {
      emit(AuthErrorState((result as Left).value));
      return left((result as Left).value);
    }

    emit(AuthenticatedState(user: (result as Right).value));
    return right(true);
  }

  Future<UserProfileData?> fetchUserProfile(UserData user) async {
    final result = await _userRepository.fetchUserProfileFromCache(user);
    return result.fold((l) {
      debugPrint(l);
      return null;
    }, (r) {
      return r;
    });
  }

  Future<Either<String, UserCredentialData>> fetchUserCredsFromCache(
      UserData user) async {
    return await _userRepository.fetchUserCredsFromCache(user);
  }
}
