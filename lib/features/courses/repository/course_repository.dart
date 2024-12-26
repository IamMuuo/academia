import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';

import 'course_local_repository.dart';
import 'course_remote_repository.dart';

final class CourseRepository {
  final CourseLocalRepository _localRepository = CourseLocalRepository();
  final CourseRemoteRepository _courseRemoteRepository =
      CourseRemoteRepository();

  /// Fetches all cached courses
  /// Incase of an error a message of type [String] is returned
  /// On success, a [List] of [CourseData] is returned
  Future<Either<String, List<CourseData>>> fetchAllCachedCourses() async {
    return await _localRepository.fetchAllCachedCourses();
  }

  Future<Either<String, List<CourseData>>> syncCoursesWithMagnet() async {
    final result = await _courseRemoteRepository.fetchCoursesFromMagnet();

    return result.fold((error) {
      return left(error);
    }, (courses) async {
      // Cache them to local db
      for (final course in courses) {
        final res = await _localRepository.addCourseToCache(course);
        if (res.isLeft()) {
          return left((res as Left).value);
        }
      }
      return right(courses);
    });
  }
}
