import 'package:academia/constants/common.dart';
import 'package:academia/models/courses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardController extends GetxController {
  TextEditingController searchBoxController = TextEditingController();

  void getNotifications() {
    debugPrint("${user.name}");
  }

  int get classesToday {
    int classes = 0;
    var courses = appDB.get("timetable") ?? [];
    for (Courses course in courses) {
      if (course.dayOfTheWeek!.title() ==
          DateFormat("EEEE").format(DateTime.now())) {
        classes++;
      }
    }
    return classes;
  }
}
