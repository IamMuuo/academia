import 'package:academia/constants/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  Rx<bool> showGPA = true.obs;
  Rx<bool> showProfilePic = true.obs;
  Rx<bool> showExamTimeTable = true.obs;
  late Map<dynamic, dynamic> settings;

  @override
  void onInit() async {
    settings = await appDB.get("settings");
    showGPA.value = settings["show_gpa"] ?? true;
    showProfilePic.value = settings["show_profile_pic"] ?? true;
    showExamTimeTable.value = settings["show_exam_timetable"] ?? true;

    debugPrint("Settings loaded!");
    super.onInit();
  }

  Future<void> saveSettings() async {
    settings["show_profile_pic"] = showProfilePic.value;
    settings["show_gpa"] = showGPA.value;
    settings["show_exam_timetable"] = showExamTimeTable.value;
    await appDB.put("settings", settings);
  }
}
