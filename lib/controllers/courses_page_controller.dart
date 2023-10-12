import 'package:academia/models/courses.dart';
import 'package:academia/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:academia/constants/common.dart";
import 'package:intl/intl.dart';

class CoursesPageController extends GetxController {
  var userCourses = <Courses>[];
  var hasCourses = true.obs;

  Future<bool> updateCourses() async {
    var courses = await magnet.fetchTimeTable();
    debugPrint(courses.toString());

    if (courses.isEmpty) {
      hasCourses.value = false;
      return false;
    }

    for (var i = 0; i < courses.length; i++) {
      userCourses.add(Courses.fromJson(courses[i]));
    }
    await appDB.put("timetable", userCourses);
    hasCourses.value = true;
    return true;
  }

  List<Widget> buildElements() {
    var courses = appDB.get("timetable") ?? [];

    var userCourses = <Widget>[];

    debugPrint(DateFormat("EEEE").format(DateTime.now()));

    for (Courses course in courses) {
      userCourses.add(CourseCard(
          backGround: DateFormat("EEEE").format(DateTime.now()) ==
                  course.dayOfTheWeek!.title()
              ? Colors.blueGrey
              : Colors.white,
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
          courseTitle: course.name.toString().title(),
          dayOfWeek: course.dayOfTheWeek.toString().title(),
          period: course.period.toString().title(),
          venue: course.room.toString().title(),
          lecturer: course.lecturer.toString().title(),
          campus: user.campus.toString().title()));
    }
    if (userCourses.isEmpty) {
      hasCourses.value = false;
    }
    return userCourses;
  }

  @override
  void onInit() async {
    if (!appDB.containsKey("timetable")) {
      hasCourses.value = false;
      var isUpdated = await updateCourses();
      if (isUpdated) {
        hasCourses.value = true;
      }
    }
    super.onInit();
  }
}
