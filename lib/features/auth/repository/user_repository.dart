import 'package:academia/database/database.dart';
import 'package:academia/features/auth/repository/user_local_repository.dart';
import 'package:academia/features/auth/repository/user_remote_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:magnet/magnet.dart';

final class UserRepository {
  final UserLocalRepository _userLocalRepository = UserLocalRepository();
  final UserRemoteRepository _userRemoteRepository = UserRemoteRepository();

  /// Fetches all users from the local cache
  /// incase of an error it will return a [String] to the left
  /// and a [List<UserData>] to the right incase users were retrived
  Future<Either<String, List<UserData>>> fetchAllUsersFromCache() async {
    return await _userLocalRepository.fetchAllUsers();
  }

  /// Adds or updates a user's information into local cache depending
  /// on whether the user data exists
  Future<Either<String, bool>> addUserToCache(UserData userData) async {
    return await _userLocalRepository.addUserToCache(userData);
  }

  /// Delete the user specified by [userData] from local cache
  /// It wil return a string describing the error that it might have
  /// encountered or a boolean [true] incase it was a success
  Future<Either<String, bool>> deleteUserFromCache(UserData userData) async {
    return await _userLocalRepository.deleteUserFromCache(userData);
  }

  /// Adds or updates a user's information into local credentials cache depending
  /// on whether the user data exists
  Future<Either<String, bool>> addUserCredsToCache(
      UserCredentialData credentials) async {
    return await _userLocalRepository.addUserCredsToCache(credentials);
  }

  /// Retrieves user credentials from cache depending
  /// on whether the user data exists
  Future<Either<String, UserCredentialData>> fetchUserCredsFromCache(
      UserData user) async {
    return await _userLocalRepository.fetchUserCredsFromCache(user);
  }

  Future<Either<String, UserData>> authenticateRemotely(
      UserCredentialData credentials) async {
    // Register a magnet singleton instance

    // TODO: (erick) enable auth with magnet
    // GetIt.instance.registerSingletonIfAbsent(
    //   () => Magnet(credentials.admno, credentials.password),
    //   instanceName: "magnet",
    // );

    // authenticate with magnet
    const magnetResult =
        // await (GetIt.instance.get<Magnet>(instanceName: "magnet").login());
        Right(Object());
    return magnetResult.fold((error) {
      return left(error.toString());
    }, (session) async {
      final results =
          await _userRemoteRepository.verisafeAuthentication(credentials);
      return results.fold((error) {
        return left(error);
      }, (user) async {
        await addUserToCache(user);
        await addUserCredsToCache(UserCredentialData(
          email: user.email!,
          username: user.username,
          admno: credentials.admno,
          password: credentials.password,
          userId: user.id,
          lastLogin: DateTime.now(),
        ));
        return right(user);
      });
    });

    // authenticate with verisafe
  }

  /// Retrieves a user's profile from the cache
  Future<Either<String, UserProfileData>> fetchUserProfileFromCache(
    UserData user,
  ) async {
    final localResult = await _userLocalRepository.fetchUserProfile(user);
    if (localResult.isRight()) {
      final profile = (localResult as Right).value;
      if (profile == null) {
        return left(
          "Failed to fetch your profile from cache please connect to the internet and refresh",
        );
      }
      return right((localResult as Right).value);
    }

    return Left((localResult as Left).value);
  }

  Future<Either<String, UserProfileData>> refreshUserProfile(
    UserData user,
  ) async {
    // Fetch from the remote db
    final remoteResult = await _userRemoteRepository.fetchUserProfile();
    if (remoteResult.isRight()) {
      final profile = (remoteResult as Right).value;
      await _userLocalRepository.addUserProfile(profile);
      return right(profile);
    }

    return (left((remoteResult as Left).value));
  }
}
