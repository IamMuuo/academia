import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:academia/models/models.dart';

class CoursesController extends GetxController {
  RxBool hasCourses = false.obs;
  RxBool isLoading = false.obs;
  RxList<Course> courses = <Course>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadCourses();
  }

  /// Loads all courses stored in the local DB
  Future<List<Course>> loadCourses() async {
    isLoading.value = true;
    final rawCourses = await CourseModelHelper().queryAll();
    courses.value = rawCourses.map((e) => Course.fromDB(e)).toList();
    if (courses.value.isEmpty) {
      hasCourses.value = false;
    } else {
      hasCourses.value = true;
    }
    isLoading.value = false;
    return courses;
  }

  Future<void> _saveCourses(List<Course> courses) async {
    await CourseModelHelper().truncate();

    for (var course in courses) {
      await CourseModelHelper().create(course.toJson());
    }
  }

  /// Scrape for a user's course using magnet
  Future<List<Course>> fetchCourses() async {
    isLoading.value = true;
    try {
      final result = await magnet.fetchTimeTable();

      // final rawCourses = rawData.cast<Map<String, dynamic>>();
      final rawCourses = [];
      courses.value = rawCourses.map((e) => Course.fromJson(e)).toList();
      _saveCourses(courses);
      if (courses.value.isEmpty) {
        hasCourses.value = false;
      } else {
        hasCourses.value = true;
      }
      isLoading.value = false;
      return courses;
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }
}
