import 'package:academia/constants/common.dart';
import 'package:academia/models/courses.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExamsTimeTableController extends GetxController {
  var hasExams = false.obs;
  var isLoading = false.obs;

  Future<List<dynamic>> fetchExamTimeTable(String units,
      {bool athi = true}) async {
    isLoading.value = true;

    try {
      var fetchedUnits = await magnet.fetchExamTimeTabale(units);
      isLoading.value = false;

      return fetchedUnits;
    } catch (e) {
      Get.snackbar(
        "Oh Snap!",
        "Something went wrong while attempting to fetch your exam timetable, please check your network connection and try again",
        icon: const Icon(
          Icons.network_ping,
        ),
        maxWidth: 500,
      );
      debugPrint(e.toString());
    }

    isLoading.value = false;
    return [];
  }

  Future<void> addFetchedUnits(List<dynamic> fetchedUnits) async {
    await appDB.put("exam_timetable", fetchedUnits);
  }

  @override
  void onInit() async {
    debugPrint(appDB.get("exam_timetable").toString());

    if (true) {
      var courses = appDB.get("timetable");
      String payload = "";
      for (Courses c in courses) {
        payload =
            "$payload ${c.name!.replaceAll("-", " ")}${c.section!.split('-')[0]},";
      }

      debugPrint(payload);
      var fetchedUnits = await fetchExamTimeTable(payload.trim());
      await addFetchedUnits(fetchedUnits);
      hasExams.value = fetchedUnits.isNotEmpty;
    }

    debugPrint("do I have exams : ${hasExams.value}");

    super.onInit();
  }
}
