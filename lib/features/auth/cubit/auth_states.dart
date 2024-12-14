import 'package:academia/database/database.dart';

/// A base class representing authentication status
abstract class AuthState {
  bool busy = false;
}

/// authentication loading state
final class AuthLoadingState extends AuthState {}

/// Initial authentication state
final class AuthInitialState extends AuthState {}

/// First time app launch
final class AuthFirstAppLaunch extends AuthState {}

/// Cached users retrieved
final class AuthCachedUsersRetrieved extends AuthState {
  final List<UserData> cachedUsers;
  AuthCachedUsersRetrieved({required this.cachedUsers});
}

// Represents an error on page state
final class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState(this.message);
}

// Represents the unauthenticated state
final class UnAuthenticatedState extends AuthState {}

final class AuthenticatedState extends AuthState {
  final UserData user;
  final bool localAuth;
  AuthenticatedState({
    required this.user,
    this.localAuth = false,
  });
}
