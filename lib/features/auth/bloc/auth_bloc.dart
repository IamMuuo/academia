import 'package:academia/core/user/models/user_role.dart';
import 'package:academia/core/user/repository/user_repository.dart';
import 'package:academia/database/database.dart';
import 'package:academia/exports/barrel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

part 'auth_event.dart';
part 'auth_state.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository = UserRepository();
  final _logger = Logger();

  AuthBloc() : super(AuthInitialState()) {
    on<AppLaunchDetected>((event, emit) async {
      emit(AuthLoadingState());
      final result = await _userRepository.fetchUserFromCache();
      return result.fold((error) {
        _logger.e(error, time: DateTime.now());
        return emit(AuthErrorState(error: error));
      }, (user) async {
        if (user == null) {
          _logger.i("No user retrieved", time: DateTime.now());
          return emit(AuthErrorState(error: "No such user"));
        }
        // query for user creds
        final credsResult = await _userRepository.fetchUserCredsFromCache(user);
        credsResult.fold((error) {
          _logger.e(error);
          return emit(AuthErrorState(error: error));
        }, (creds) async {
          _logger.i("User credentials retrieved");

          magnet = GetIt.instance.registerSingletonIfAbsent(
            () => Magnet(creds.admno!, creds.password),
            instanceName: "magnet",
          );

          _logger.i(
            "Magnet instance instanciated with cached credentials for user ${creds.admno}",
          );

          _userRepository.authenticateRemotely(
            creds,
            refresh: true,
          );

          return emit(AuthenticatedState(user: user));
        });
      });
    });

    on<AuthenticationRequested>((event, emit) async {
      if (event.password.trim().isEmpty || event.password.trim().length < 6) {
        return emit(AuthErrorState(error: "Please enter a valid password"));
      }
      if (event.admno.trim().isEmpty) {
        return emit(
          AuthErrorState(error: "Please enter a valid admission number"),
        );
      }

      emit(AuthLoadingState());
      final result = await _userRepository.authenticateRemotely(
        UserCredentialData(
            admno: event.admno.trim(),
            username: '',
            email: '',
            password: event.password.trim()),
      );

      return result.fold((error) {
        _logger.e(error, time: DateTime.now());
        return emit(AuthErrorState(error: error));
      }, (user) {
        return emit(AuthenticatedState(user: user));
      });
    });

    // Registration flow

    on<RegistrationEventRequested>((event, emit) async {
      if (event.password.trim().isEmpty || event.password.trim().length < 6) {
        return emit(AuthErrorState(error: "Please enter a valid password"));
      }
      if (event.admno.trim().isEmpty) {
        return emit(
          AuthErrorState(error: "Please enter a valid admission number"),
        );
      }

      emit(AuthLoadingState());
      final result = await _userRepository.fetchUserDetailsFromMagnet(
        UserCredentialData(
            admno: event.admno.trim(),
            username: '',
            email: '',
            password: event.password.trim()),
      );

      return result.fold((error) {
        _logger.e(error, time: DateTime.now());
        return emit(AuthErrorState(error: error));
      }, (user) {
        // add user password to the dict
        user['profile'] = user['profile']!.split(',').last;
        user.addAll({'password': event.password});
        _logger.d('user fetched');
        return emit(NewAuthUserDetailsFetched(userDetails: user));
      });
    });

    on<SignupEventRequested>((event, emit) async {
      emit(AuthLoadingState());
      final result = await _userRepository.completeRegistration(
        event.user,
        event.profile,
        event.creds,
      );

      return result.fold((error) {
        _logger.e(error, time: DateTime.now());
        return emit(AuthErrorState(error: error));
      }, (user) {
        emit(AuthenticatedState(user: user));
      });
    });

    on<AddIsoulEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await _userRepository.completeRegistration(
        event.user,
        event.profile,
        event.creds,
      );

      return result.fold((error) {
        _logger.e(error, time: DateTime.now());
        return emit(AuthErrorState(error: error));
      }, (user) {
        _userRepository.deleteUserFromCache(user);
        add(AppLaunchDetected());
      });
    });

    on<LogoutRequested>((event, emit) async {
      emit(AuthLoadingState());

      final result = await _userRepository.logout(event.user);

      result.fold((error) {
        _logger.e(error, error: error);
        emit(AuthErrorState(error: error));

        // To prevent errors since the user logout was unsuccessfull
        emit(AuthenticatedState(user: event.user));
      }, (message) {
        emit(UnauthenticatedState(message: message));
      });
    });
  }

  Future<List<UserRole>?> fetchUserRole(String userID) async {
    final userRoleResponse = await _userRepository.fetchUserRole(userID);
    return userRoleResponse.fold((error) {
      _logger.e(error);
      return null;
    }, (roles) {
      return roles;
    });
  }
}
