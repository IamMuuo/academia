import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';

/// Repository for manipulation of user related information
/// in the application's local cache
final class UserLocalRepository {
  // the db's instance
  final AppDatabase _localDb = GetIt.instance.get(instanceName: "cacheDB");

  /// Fetches all users from the local cache
  /// incase of an error it will return a [String] to the left
  /// and a [List<UserData>] to the right incase users were retrived
  Future<Either<String, List<UserData>>> fetchAllUsers() async {
    try {
      final users = await _localDb.user.select().get();
      return right(users);
    } catch (e) {
      return left("Failed to retrieve users with message ${e.toString()}");
    }
  }

  /// Adds or updates a user's information into local cache depending
  /// on whether the user data exists
  Future<Either<String, bool>> addUserToCache(UserData userData) async {
    try {
      final ok = await _localDb.into(_localDb.user).insertOnConflictUpdate(
            userData.toCompanion(true),
          );
      if (ok != 0) {
        return right(true);
      }
      return left(
        "The specified user data was not inserted since it exists and confliced",
      );
    } catch (e) {
      return left(
        "Failed to append user to cache with error description ${e.toString()}",
      );
    }
  }

  /// Delete the user specified by [userData] from local cache
  /// It wil return a string describing the error that it might have
  /// encountered or a boolean [true] incase it was a success
  Future<Either<String, bool>> deleteUserFromCache(UserData userData) async {
    try {
      final ok = await _localDb.delete(_localDb.user).delete(userData);
      if (ok != 0) {
        return right(true);
      }
      return left(
        "The specified user was not deleted because they do not exist",
      );
    } catch (e) {
      return left(
        "Failed to delete user from cache with error description ${e.toString()}",
      );
    }
  }

  /// Adds or updates a user's information into local credentials cache depending
  /// on whether the user data exists
  Future<Either<String, bool>> addUserCredsToCache(
      UserCredentialData credentials) async {
    try {
      final ok =
          await _localDb.into(_localDb.userCredential).insertOnConflictUpdate(
                credentials.toCompanion(true),
              );
      if (ok != 0) {
        return right(true);
      }
      return left(
        "The specified user credentials data was not inserted since it exists and confliced",
      );
    } catch (e) {
      return left(
        "Failed to append user credentials to cache with error description ${e.toString()}",
      );
    }
  }

  /// Retrieves user credentials from cache depending
  /// on whether the user data exists
  Future<Either<String, UserCredentialData>> fetchUserCredsFromCache(
      UserData user) async {
    try {
      final creds = await _localDb.managers.userCredential
          .filter((f) => f.userId.id.equals(user.id))
          .getSingleOrNull(distinct: true);

      if (creds == null) {
        throw ("User credentials does not exist in cache!");
      }
      return right(creds);
    } catch (e) {
      return left(
        "Failed to retrieve user credentials from cache with error description ${e.toString()}",
      );
    }
  }

  /// Sets a user's profile to the cache
  Future<Either<String, bool>> addUserProfile(UserProfileData profile) async {
    try {
      final ok =
          await _localDb.into(_localDb.userProfile).insertOnConflictUpdate(
                profile.toCompanion(true),
              );
      if (ok != 0) {
        return right(true);
      }
      return left(
        "The specified user profile data was not inserted since it exists and confliced",
      );
    } catch (e) {
      return left(
        "Failed to append user profile to cache with error description ${e.toString()}",
      );
    }
  }

  /// Retrieves a user's profile from the cache
  Future<Either<String, UserProfileData?>> fetchUserProfile(
      UserData user) async {
    try {
      // final profile =
      final profile = await _localDb.managers.userProfile
          .filter((f) => f.userId.id.equals(user.id))
          .getSingleOrNull(distinct: true);
      return right(profile);
    } catch (e) {
      return left(
        "Failed to fetch cached user profile to cache with error description ${e.toString()}",
      );
    }
  }
}
