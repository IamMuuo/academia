import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class ExamsTimeTableController extends GetxController {
  Future<void> fetchExams() async {
    await Future.delayed(const Duration(seconds: 10));
    return;
  }

  List<Courses> userCourses = <Courses>[];
  @override
  Future<void> onInit() async {
    super.onInit();
    // Load user courses
    debugPrint(appDB.keys.toString());
    final List coursesData = await appDB.get("timetable");
    coursesData.forEach((element) {
      if (element != null) {
        userCourses.add(element);
      }
    });
    debugPrint("User Courses Fetched");
    // userCourses =
    //     courses.map((e) => Courses.fromJson(e as Map)).toList().cast<Courses>();
  }
}
