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
  Rx<int> progress = 0.obs;
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
  var tasks = [].obs;

  void getTasks() {
    tasks.clear();
    final tasksList = appDB.get("tasks") ?? [];
    for (final task in tasksList) {
      tasks.add(task);
    }
    debugPrint("Title: ${tasks[0].title}");
  }

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

  void updateTask(
      String newTaskType,
      String newTaskTitle,
      String newTaskDescription,
      String newUnit,
      DateTime newDate,
      int progress) {
    taskType.value = newTaskType;
    taskTitle.value = newTaskTitle;
    taskDescription.value = newTaskDescription;
    selectedUnit.value = newUnit;
    selectedDeadline.value = newDate;
    this.progress.value = progress;
  }

  void updateTaskProgress(int newProgress) {
    progress.value = newProgress;

    // Update the progress of the task in the database
    final tasksList = appDB.get("tasks") ?? [];
    for (final task in tasksList) {
      if (task.title == taskTitle.value) {
        task.progress = newProgress;
        break;
      }
    }
    appDB.put("tasks", tasksList);
    getTasks();
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
    getTasks();
    return;
  }

  void loadRegisteredUnits() {
    final courses = appDB.get("timetable");
    if (courses != null && coursesList.isEmpty) {
      for (final course in courses) {
        Unit unit = Unit(name: course.name, creditHours: 0, grade: 'A');
        coursesList.add(unit);
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
    getTasks();
  }

  Future<void> editTask(
      String newTaskTitle,
      String newTaskDescription,
      String newTaskType,
      String newTaskUnit,
      DateTime newTaskDeadline,
      int newTaskProgress) async {
    final tasksList = appDB.get("tasks") ?? [];
    for (final task in tasksList) {
      if (task.title == taskTitle.value) {
        task.title = newTaskTitle;
        task.description = newTaskDescription;
        task.type = newTaskType;
        task.unit = newTaskUnit;
        task.deadline = newTaskDeadline;
        task.progress = newTaskProgress;
        break;
      }
    }
    await appDB.put("tasks", tasksList);
    getTasks();
    // update all the other variables
    taskTitle.value = newTaskTitle;
    taskDescription.value = newTaskDescription;
    taskType.value = newTaskType;
    selectedUnit.value = newTaskUnit;
    selectedDeadline.value = newTaskDeadline;
    progress.value = newTaskProgress;
  }

  Future<void> deleteTask(Task task) async {
    final tasksList = appDB.get("tasks") ?? [];
    tasksList.remove(task);
    await appDB.put("tasks", tasksList);
    getTasks();
  }
}
