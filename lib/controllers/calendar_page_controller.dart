import 'package:academia/constants/common.dart';
import 'package:academia/models/schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarPageController extends GetxController {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescription = TextEditingController();
  final TextEditingController taskTime = TextEditingController();
  String? scheduleDate;

  List? schedules;

  // load schedules

  CalendarPageController() {
    loadSchedules();
  }

  void printSchedules() {
    for (int i = 0; i < schedules!.length; i++) {
      debugPrint("Schedule ${schedules![i].taskName}");
    }
  }

  void saveSchedule() {
    appDB
        .put("schedules", schedules)
        .then((value) => debugPrint("Schedule saved successfully"))
        .catchError((error) {
      debugPrint("An error occuerred: $error");
    }).whenComplete(() => debugPrint("Done!"));
  }

  void addSchedule() {
    final Schedule s = Schedule();
    s.taskName = taskNameController.text;
    s.taskDate = taskTime.text;
    s.taskDescription = taskDescription.text;
    s.taskDate = scheduleDate;

    schedules!.add(s);

    saveSchedule();
  }

  void loadSchedules() {
    // dos it contain the damn key?
    if (appDB.containsKey("schedules")) {
      schedules = appDB.get("schedules");
    } else {
      schedules = <Schedule>[];
    }
    printSchedules();
  }
}
