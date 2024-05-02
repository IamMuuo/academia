import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:academia/models/models.dart';

class CoursesController extends GetxController {
  RxBool hasCourses = false.obs;
  RxList<Course> courses = <Course>[].obs;

  /// Loads all courses stored in the local DB
  Future<List<Course>> loadCourses() async {
    final rawCourses = await CourseModelHelper().queryAll();
    courses.value = rawCourses.map((e) => Course.fromJson(e)).toList();
    return courses;
  }

  /// Scrape for a user's course using magnet
  Future<List<Course>> fetchCourses() async {
    try {
      final rawData = await magnet.fetchAllCourses();
      final rawCourses = rawData.cast<Map<String, dynamic>>();
      courses.value = rawCourses.map((e) => Course.fromJson(e)).toList();
      return courses;
    } catch (e) {
      rethrow;
    }
  }
}
