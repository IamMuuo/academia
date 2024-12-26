import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:magnet/magnet.dart';

final class CourseRemoteRepository {
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
}
