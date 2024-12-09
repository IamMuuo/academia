import 'package:academia/database/database.dart';
import 'package:academia/features/auth/repository/user_local_repository.dart';
import 'package:dartz/dartz.dart';

final class UserRepository {
  final UserLocalRepository _userLocalRepository = UserLocalRepository();

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
}
