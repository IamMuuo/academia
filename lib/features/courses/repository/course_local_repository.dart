import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:get_it/get_it.dart';

/// [CourseLocalRepository]
/// A Helper class to manipulate course related information
/// on the device local storage
final class CourseLocalRepository {
  // the db's instance
  final AppDatabase _localDb = GetIt.instance.get(instanceName: "cacheDB");

  /// Fetches all cached courses
  /// Incase of an error a message of type [String] is returned
  /// On success, a [List] of [CourseData] is returned
  Future<Either<String, List<CourseData>>> fetchAllCachedCourses(
      UserData user) async {
    try {
      final courses = await _localDb.managers.course
          .filter((c) => c.user.id.equals(user.id))
          .get(distinct: true);
      return right(courses);
    } catch (e) {
      return left("Failed to retrieve users with message ${e.toString()}");
    }
  }

  /// Adds a [CourseData] specified by [course] to [_localDb] cache
  /// This method can also be used to update courses since it also updates the
  /// information on conflict
  Future<Either<String, bool>> addCourseToCache(CourseData course) async {
    try {
      final ok = await _localDb.into(_localDb.course).insert(
            course.toCompanion(true),
            mode: InsertMode.insertOrReplace,
          );
      if (ok != 0) {
        return right(true);
      }
      return left(
        "The specified course data was not inserted since it exists and conflicted",
      );
    } catch (e) {
      return left(
        "Failed to append course to cache with error description ${e.toString()}",
      );
    }
  }

  /// Delete the [CourseData] specified by [course] from local cache
  /// It wil return an instance of [String] describing the error that it might have
  /// encountered or a boolean [true] incase it was a success
  Future<Either<String, bool>> deleteCourseFromCache(CourseData course) async {
    try {
      final ok = await _localDb.delete(_localDb.course).delete(course);
      if (ok != 0) {
        return right(true);
      }
      return left(
        "The specified course was not deleted because it does not exist",
      );
    } catch (e) {
      return left(
        "Failed to delete course from cache with error description ${e.toString()}",
      );
    }
  }
}
