import 'package:academia/exports/barrel.dart';
import 'package:academia/models/courses.dart';
import 'package:academia/services/storage_service.dart';
import 'package:academia/widgets/course_attendance_widget.dart';
import 'package:academia/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:academia/constants/common.dart";
import 'package:intl/intl.dart';
import 'package:academia/controllers/controllers.dart';

class CoursesPageController extends GetxController {
  var userCourses = <Courses>[];
  var hasCourses = true.obs;
  var hasProgress = true.obs;
  final UserController userController = Get.find<UserController>();

  Future<bool> updateCourses() async {
    try {
      magnet = magnet ?? Magnet("", "");
      var courses = await magnet.fetchTimeTable();

      if (courses.isEmpty) {
        hasCourses.value = false;
        return false;
      }
      await StorageService().appDB.delete("timetable");
      userCourses.clear();

      for (var i = 0; i < courses.length; i++) {
        userCourses.add(Courses.fromJson(courses[i]));
      }
      await StorageService().appDB.put("timetable", userCourses);
      hasCourses.value = true;

      await updateProgress();
      return true;
    } catch (e) {
      Get.snackbar("Error",
          "We could not establish internet connection to refresh your courses, Please check your connection and try again!",
          icon: const Icon(Icons.network_locked));
    }
    return false;
  }

  List<Widget> buildElements() {
    var courses = StorageService().appDB.isOpen
        ? StorageService().appDB.get("timetable") ?? []
        : [];

    var userCourses = <Widget>[];

    for (Courses course in courses) {
      userCourses.add(
        CourseCard(
          backGround: DateFormat("EEEE").format(DateTime.now()) ==
                  course.dayOfTheWeek!.title()
              ? Colors.blueGrey
              : Colors.transparent,
          titleColor: DateFormat("EEEE").format(DateTime.now()) ==
                  course.dayOfTheWeek!.title()
              ? Colors.white
              : Colors.blueGrey,
          borderColor: DateFormat("EEEE").format(DateTime.now()) ==
                  course.dayOfTheWeek!.title()
              ? Colors.transparent
              : Colors.blueGrey,
          keyStyle: DateFormat("EEEE").format(DateTime.now()) ==
                  course.dayOfTheWeek!.title()
              ? const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                )
              : const TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
          valueStyle: DateFormat("EEEE").format(DateTime.now()) ==
                  course.dayOfTheWeek!.title()
              ? const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                )
              : const TextStyle(
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
          courseTitle: course.name.toString(),
          dayOfWeek: course.dayOfTheWeek.toString().title(),
          period: course.period.toString().title(),
          venue: course.room.toString(),
          lecturer: course.lecturer.toString().title(),
          campus:
              userController.user.value?.campus.toString().title() ?? "athi",
        ),
      );
    }
    if (userCourses.isEmpty) {
      hasCourses.value = false;
    }
    return userCourses;
  }

  List<Widget> buildProgressCards() {
    var progress = StorageService().appDB.get("attendance") ?? [];

    if (progress == []) {
      hasProgress.value = false;
      return [];
    }

    var progressList = <Widget>[];

    for (Map p in progress) {
      progressList.add(CourseAttendanceCard(
        course: p.keys.first,
        percent: double.parse(p.values.first.toString()),
      ));
    }
    return progressList;
  }

  int get numOfClasses {
    if (StorageService().appDB.containsKey("timetable")) {
      var courses = StorageService().appDB.get("timetable") ?? [];
      return courses.length;
    }
    return 0;
  }

  Future<bool> updateProgress() async {
    var courseProgress = await magnet.fetchUserClassAttendance();
    await StorageService().appDB.put("attendance", courseProgress);
    return true;
  }

  @override
  void onInit() async {
    try {
      if (!StorageService().appDB.containsKey("timetable")) {
        hasCourses.value = false;
        var isUpdated = await updateCourses();
        if (isUpdated) {
          hasCourses.value = true;
        }
      }

      if (!StorageService().appDB.containsKey("attendance")) {
        hasProgress.value = false;
        var updatedProgress = await updateProgress();
        if (updatedProgress) {
          hasProgress.value = true;
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "It seems we couldn't find your timetable, please review your connection and if the problem persits consider logging out and loggin in again",
        icon: const Icon(Icons.network_wifi),
      );
    }
    super.onInit();
  }
}
