import 'package:academia/models/courses.dart';
import 'package:academia/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "package:academia/constants/common.dart";

class CoursesPageController extends GetxController {
  var allCourses = <Courses>[].obs;
  var userTimeTable = <Courses>[].obs;
  CoursesPageController() {
    if (appDB.containsKey("timetable")) {
      userTimeTable.value = appDB.get("timetable").cast<Courses>();
    }
    if (appDB.containsKey("allCourses")) {
      allCourses.value = appDB.get("allCourses").cast<Courses>();
    }
  }

  List<Widget> buildTimeTableCourses() {
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

  List<DataColumn> buildDataColumn() {
    return const [
      DataColumn(label: Text("Course")),
      DataColumn(label: Text("Lecturer")),
      DataColumn(label: Text("Period")),
      DataColumn(label: Text("Day")),
      DataColumn(label: Text("Venue")),
    ];
  }

  List<DataRow> buildDataRow() {
    List<DataRow> datarow = <DataRow>[];
    for (var course in allCourses) {
      datarow.add(
        DataRow(
          cells: [
            DataCell(Text(course.name!)),
            DataCell(Text(course.lecturer!)),
            DataCell(Text(course.period!)),
            DataCell(Text(course.dayOfTheWeek!.title())),
            DataCell(Text(course.venue ?? course.room!)),
          ],
        ),
      );
    }
    return datarow;
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
