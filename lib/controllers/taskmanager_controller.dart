import 'package:academia/constants/common.dart';
import 'package:academia/models/courses.dart';
import 'package:academia/models/tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskManagerController extends GetxController {
  Rx<DateTime> selectedDeadline = DateTime.now().obs;
  Rx<String> selectedUnit = "".obs;
  Rx<String> taskType = "".obs;
  Rx<String> taskTitle = "".obs;
  Rx<String> taskDescription = "".obs;
  final RxList<Unit> coursesList = <Unit>[].obs;
  Unit other = Unit(name: "Other", creditHours: 0, grade: "A");
  final RxList<String> taskTypes = <String>[
    "Assignment",
    "Quiz",
    "Midsem",
    "Endsem",
    "Project",
    "Other"
  ].obs;
  var isloading = false.obs;

  void updateDeadline(DateTime newDate) {
    selectedDeadline.value = newDate;
  }

  void updateUnit(String newUnit) {
    selectedUnit.value = newUnit;
  }

  void updateTaskType(String newTaskType) {
    taskType.value = newTaskType;
  }

  void updateTaskTitle(String newTaskTitle) {
    taskTitle.value = newTaskTitle;
  }

  void updateTaskDescription(String newTaskDescription) {
    taskDescription.value = newTaskDescription;
  }

  void updateTask(String newTaskType, String newTaskTitle,
      String newTaskDescription, String newUnit, DateTime newDate) {
    taskType.value = newTaskType;
    taskTitle.value = newTaskTitle;
    taskDescription.value = newTaskDescription;
    selectedUnit.value = newUnit;
    selectedDeadline.value = newDate;
  }

  Future<void> addTask() async {
    // debugPrint(taskTitle.value);
    // appDB.delete("tasks");
    var list = appDB.get("tasks") ?? [];
    list.add(Task(
        deadline: selectedDeadline.value,
        unit: selectedUnit.value,
        type: taskType.value,
        title: taskTitle.value,
        description: taskDescription.value));

    await appDB.put("tasks", list);
    var tasks = await appDB.get("tasks") ?? [];
    for (Task task in tasks) {
      debugPrint(task.title);
    }
    // debugPrint('${appDB.get("tasks")}');
    return;
  }

  void loadRegisteredUnits() {
    final courses = appDB.get("timetable");
    if (courses != null) {
      for (final course in courses) {
        coursesList.add(course);
      }
    }
    if (!coursesList.contains(other)) {
      coursesList.add(other);
    }
  }

  void clearTaskManager() {
    selectedDeadline.value = DateTime.now();
    selectedUnit.value = "";
    taskType.value = "";
    taskTitle.value = "";
    taskDescription.value = "";
  }
}
