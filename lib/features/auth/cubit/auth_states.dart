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

// Represents an error on page state
final class AuthErrorState extends AuthState {
  final String message;
  AuthErrorState(this.message);
}

// Represents authenticated state
final class AuthenticatedState extends AuthState {
  final UserData user;
  final String? verisafeToken;
  final Magnet? magnet;

  AuthenticatedState({
    required this.user,
    this.verisafeToken,
    this.magnet,
  });
}

// Represents the unauthenticated state
final class UnAuthenticatedState extends AuthState {}
