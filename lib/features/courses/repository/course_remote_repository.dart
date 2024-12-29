import 'package:academia/database/database.dart';
import 'package:academia/utils/network/network.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:magnet/magnet.dart';

final class CourseRemoteRepository with DioErrorHandler {
  final DioClient _dioClient = DioClient();

  /// Fetches courses from magnet.
  Future<Either<String, List<CourseData>>> fetchCoursesFromMagnet() async {
    final magnetInstance = GetIt.instance.get<Magnet>(instanceName: "magnet");
    final magnetResult = await magnetInstance.fetchUserTimeTable();
    return magnetResult.fold((error) {
      return left(error.toString());
    }, (courses) {
      return right(courses.map((c) => CourseData.fromJson(c)).toList());
    });
  }

  /// Sync courses with wookie
  Future<Either<String, bool>> syncCourseWithWookie(CourseData course) async {
    try {
      final response = await _dioClient.dio.post(
        "/wookie/courses/create",
        data: course.toJson(),
      );
      if (response.statusCode == 201) {
        return right(true);
      }
      return right(false);
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left("Something went terribly wrong please try that later");
    }
  }
}
