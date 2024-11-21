import 'package:academia/database/database.dart';
import 'package:magnet/magnet.dart';

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

class AuthenticatedState extends AuthState {}

// Represents a partially authenticated state in the event that a user
// does not have internet access
class PartiallyAuthenticatedState extends AuthenticatedState {
  final UserData user;
  PartiallyAuthenticatedState({required this.user});
}

// Represents a fully authenticated state whereby the user is authenticated
// both by verisafe and magnet
final class FullyAuthenticatedState extends AuthenticatedState {
  final UserData user;
  final String verisafeToken;
  final Magnet magnet;

  FullyAuthenticatedState({
    required this.user,
    required this.verisafeToken,
    required this.magnet,
  });
}

// Represents the unauthenticated state
final class UnAuthenticatedState extends AuthState {}
