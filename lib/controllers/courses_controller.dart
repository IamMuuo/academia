import 'package:academia/constants/common.dart';
import 'package:get/get.dart';
import 'package:academia/models/models.dart';
import 'package:dartz/dartz.dart';

class CoursesController extends GetxController {
  RxBool hasCourses = false.obs;
  RxList<Course> courses = <Course>[].obs;
  RxList<CourseTopic> coursesTopics = <CourseTopic>[].obs;

  @override
  void onInit() {
    super.onInit();
    CourseModelHelper().queryAll().then((value) {
      courses.value = value.map((e) => Course.fromJson(e)).toList();
    });

    // Load the course topics
    CourseTopicModelHelper().queryAll().then((value) {
      coursesTopics.value = value.map((e) => CourseTopic.fromJson(e)).toList();
    });
  }

  /// Fetches the curent user's courses and saves them to local storage
  Future<Either<String, List<Course>>> fetchUserCourses() async {
    final result = await magnet.fetchUserTimeTable();
    return result.fold((l) {
      return left("Sorry we couldn't find your courses please try again later");
    }, (r) {
      courses.value = r.map((e) => Course.fromJson(e)).toList();

      /// Write the courses to local db
      for (final course in courses) {
        CourseModelHelper().create(course.toJson());
      }
      return right(courses);
    });
  }

  int get numberOfCoursesToday {
    int today = DateTime.now().weekday;
    int count = 0;

    for (final course in courses) {
      if (getNumericDayOfWeek(course.dayOfWeek) == today) {
        count++;
      }
    }
    return count;
  }
}
