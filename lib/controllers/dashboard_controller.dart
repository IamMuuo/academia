import 'package:academia/constants/common.dart';
import 'package:academia/controllers/taskmanager_controller.dart';
import 'package:academia/models/courses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashboardController extends GetxController {
  TextEditingController searchBoxController = TextEditingController();

  double get weekPercent {
    int weekDay = DateTime.now().weekday;
    return weekDay / 7;
  }

  double get semesterPercent {
    var month = DateTime.now().month;
    if (month > DateTime.january && month < DateTime.april) {
      return month / DateTime.april;
    } else if (month > DateTime.april && month < DateTime.july) {
      return month / DateTime.july;
    }
    return month / DateTime.december;
  }

  String get getDayPercentQuote {
    if (daypercent > 0.75) {
      return "Perhaps much is already done!";
    } else if (daypercent > 0.5) {
      return "Sun down approaches";
    } else if (daypercent > 0.25) {
      return "Its almost midday☀️";
    }
    return "The early bird..!";
  }

  String get getWeekPercentQuote {
    if (weekPercent > 0.75) {
      return "The weekend 🙃!";
    } else if (daypercent > 0.5) {
      return "Weekend is coming😉";
    } else if (daypercent > 0.25) {
      return "Focus, its tough we get it";
    }
    return "Nothing to say?";
  }

  String get getSemesterPercentQuote {
    if (semesterPercent > 0.90) {
      return "Relax, it was a tough one!😅";
    } else if (semesterPercent > 0.75) {
      return "Projects, exams panic!";
    } else if (semesterPercent > 0.5) {
      return "Its about to get real messy";
    } else if (semesterPercent > 0.25) {
      return "CATS CATS, cats all the way";
    }
    return "Ready, aim shoot!";
  }

  double get daypercent {
    int hours = DateTime.now().hour;
    return (hours / 24);
  }

  int get classesTodayCount {
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

  int get numberofTasks {
    var taskscontroller = Get.find<TaskManagerController>();
    taskscontroller.getTasks();
    return taskscontroller.tasks.length;
  }

  int get classesTommorrowCount {
    int classes = 0;
    var courses = appDB.get("timetable") ?? [];
    for (Courses course in courses) {
      if (course.dayOfTheWeek!.title() ==
          DateFormat("EEEE")
              .format(DateTime.now().add(const Duration(hours: 24)))) {
        classes++;
      }
    }
    return classes;
  }

  List<Courses> get classesToday {
    List<Courses> classes = <Courses>[];

    var courses = appDB.get("timetable") ?? [];
    for (Courses course in courses) {
      if (course.dayOfTheWeek!.title() ==
          DateFormat("EEEE").format(DateTime.now())) {
        classes.add(course);
      }
    }

    return classes;
  }

  List<Courses> get classesTommorrow {
    List<Courses> classes = <Courses>[];
    var courses = appDB.get("timetable") ?? [];
    for (Courses course in courses) {
      if (course.dayOfTheWeek!.title() ==
          DateFormat("EEEE")
              .format(DateTime.now().add(const Duration(hours: 24)))) {
        classes.add(course);
      }
    }
    return classes;
  }
}
