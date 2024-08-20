import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

class EventsController extends GetxController {
  late SharedPreferences prefs;
  Rxn<Semester> currentSemester = Rxn<Semester>();
  final SemesterService semesterService = SemesterService();

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    final semData = prefs.getString("semester");

    if (semData != null) {
      currentSemester.value = Semester.fromJson(json.decode(semData));
      return;
    }

    if (semData == null ||
        currentSemester.value!.endDate.isBefore(DateTime.now())) {
      // fetch the current semester
      final result = await semesterService.fetchCurrentSemester();
      result.fold((l) {}, (r) async {
        await prefs.setString("semester", json.encode(r.toJson()));
        currentSemester.value = r;
      });
    }
  }
}
