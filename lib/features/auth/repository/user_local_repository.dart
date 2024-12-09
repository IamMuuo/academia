import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

/// Repository for manipulation of user related information
/// in the application's local cache
final class UserLocalRepository {
  // the db's instance
  final AppDatabase _localDb = LocalDatabase().getInstance();

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
}
