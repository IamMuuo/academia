import 'package:academia/constants/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  Rx<bool> showGPA = true.obs;
  Rx<bool> showProfilePic = true.obs;
  Rx<bool> showExamTimeTable = false.obs;
  Rx<bool> showTranscript = false.obs;
  Rx<bool> showAudit = false.obs;
  Rx<bool> showFees = true.obs;
  late Map<dynamic, dynamic> settings;

  @override
  void onInit() async {
    settings = await appDB.get("settings");
    showGPA.value = settings["show_gpa"] ?? true;
    showProfilePic.value = settings["show_profile_pic"] ?? true;
    showExamTimeTable.value = settings["show_exam_timetable"] ?? true;
    showAudit.value = settings["show_audit"] ?? true;
    showTranscript.value = settings["show_transcript"] ?? true;
    showFees.value = settings["show_fees"] ?? false;

    debugPrint("Settings loaded!");
    super.onInit();
  }

  Future<void> saveSettings() async {
    settings["show_profile_pic"] = showProfilePic.value;
    settings["show_gpa"] = showGPA.value;
    settings["show_exam_timetable"] = showExamTimeTable.value;
    settings["show_transcript"] = showTranscript.value;
    settings["show_audit"] = showAudit.value;
    settings["show_fees"] = showFees.value;
    await appDB.put("settings", settings);
  }
}
