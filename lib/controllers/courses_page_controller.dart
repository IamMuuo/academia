import 'package:academia/models/courses.dart';
import 'package:academia/widgets/course_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:academia/constants/common.dart";

class CoursesPageController extends GetxController {
  var allCourses = <Courses>[].obs;
  var userTimeTable = <Courses>[].obs;
  CoursesPageController() {
    if (appDB.containsKey("timetable")) {
      debugPrint("TT present");
      userTimeTable.value = appDB.get("timetable").cast<Courses>();
    }
    if (appDB.containsKey("allCourses")) {
      debugPrint("all courses present");
      allCourses.value = appDB.get("allCourses").cast<Courses>();
    }

    // userTimeTable.value = appDB.containsKey("timetable")
    //     ? appDB.get("timetable") as List<Courses>
    //     : <Courses>[];
    // allCourses.value = appDB.containsKey("allCourses")
    //     ? appDB.get("allCourses") as List<Courses>
    //     : <Courses>[];
  }

  List<Widget> buildTimeTableCourses() {
    debugPrint(userTimeTable.length.toString());
    List<Widget> courseCards = [];

    for (var course in userTimeTable) {
      courseCards.add(CourseCard(
        borderColor: Colors.blueGrey,
        backGround: Colors.blueGrey,
        courseTitle: course.name!,
        dayOfWeek: course.dayOfTheWeek!,
        period: course.period!,
        venue: course.venue ?? course.room!,
        lecturer: course.lecturer!,
        campus: course.section!,
        icon: const Icon(
          Icons.person,
          color: Colors.white,
        ),
      ));
    }
    return courseCards;
  }

  Future<void> updateCourses() async {
    var userTT = await magnet.fetchTimeTable();
    var allCourses = await magnet.fetchAllCourses();

    var userTimeTable = <Courses>[];

    for (var course in userTT) {
      userTimeTable.add(Courses.fromJson(course));
    }

    var allFetchedCourses = <Courses>[];
    for (var course in allCourses) {
      allFetchedCourses.add(Courses.fromJson(course));
    }

    debugPrint(allFetchedCourses.length.toString());

    debugPrint(userTimeTable.length.toString());

    // store the timetable courses and course
    await appDB.put("timetable", userTimeTable);
    await appDB.put("allCourses", allFetchedCourses);
  }
}
