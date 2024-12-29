import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';

import 'course_local_repository.dart';
import 'course_remote_repository.dart';

final class CourseRepository {
  final CourseLocalRepository _localRepository = CourseLocalRepository();
  final CourseRemoteRepository _courseRemoteRepository =
      CourseRemoteRepository();

  /// Fetches all cached courses
  /// Incase of an error a message of type [String] is returned
  /// On success, a [List] of [CourseData] is returned
  Future<Either<String, List<CourseData>>> fetchAllCachedCourses(
      UserData user) async {
    return await _localRepository.fetchAllCachedCourses(user);
  }

  Future<Either<String, List<CourseData>>> syncCoursesWithMagnet(
      UserData user) async {
    final result = await _courseRemoteRepository.fetchCoursesFromMagnet();

    return result.fold((error) {
      return left(error);
    }, (courses) async {
      // Cache them to local db
      for (final course in courses) {
        syncCourseWithWookie(course);
        final res = await _localRepository.addCourseToCache(
          course.copyWith(user: Value(user.id)),
        );
        if (res.isLeft()) {
          return left((res as Left).value);
        }
      }
      return right(courses);
    });
  }

  /// Saves [course] to the local cache
  /// Useful for updating information on a course
  Future<Either<String, bool>> saveCourseToCache(CourseData course) async {
    return await _localRepository.addCourseToCache(course);
  }

  Future<Either<String, bool>> syncCourseWithWookie(CourseData course) async {
    return await _courseRemoteRepository.syncCourseWithWookie(course);
  }
}
