import 'package:academia/constants/common.dart';
import 'package:academia/models/schedule.dart';
import 'package:academia/widgets/task_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarPageController extends GetxController {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescription = TextEditingController();
  final TextEditingController taskTime = TextEditingController();
  String? scheduleDate;

  List? schedules = [].obs;
  var isLoading = true.obs;

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
    }).whenComplete(() => Get.snackbar(
              "success",
              "Your schedule was saved successfully!",
              icon: const Icon(
                CupertinoIcons.checkmark_circle,
                color: Colors.green,
              ),
              backgroundColor: Colors.white,
            ));
  }

  void addSchedule() {
    if (taskNameController.value.text.isEmpty) {
      Get.snackbar(
        "Error",
        "You must atleast specify the name of your task before saving",
        backgroundColor: Colors.white,
        icon: const Icon(
          CupertinoIcons.xmark_circle,
          color: Colors.red,
        ),
      );
      return;
    }
    final Schedule s = Schedule();
    s.taskName = taskNameController.text;
    s.taskTime = taskTime.text;
    s.taskDescription = taskDescription.text;
    s.taskDate = scheduleDate;

    schedules!.add(s);
    schedules?.sort((a, b) => a.taskDate!.compareTo(b.taskDate!));
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

  List<Widget> buildTasksCards() {
    if (schedules!.isNotEmpty) {
      List<Widget> tasks = [];
      tasks.add(
        const Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            "Your saved schedules",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
      );
      for (int i = 0; i < schedules!.length; i++) {
        debugPrint(
            "Schedule: ${schedules![i].taskName}\n ${schedules![i].taskTime}");
        tasks.add(TaskCard(
          taskName: schedules![i].taskName,
          taskTime: schedules![i].taskTime,
          taskDate: DateFormat.yMMMMEEEEd()
              .format(DateTime.parse(schedules![i].taskDate)),
          ondelete: () {
            isLoading.value = true;
            schedules!.remove(schedules![i]);
            saveSchedule();
            buildTasksCards();
          },
        ));
      }
      isLoading.value = false;
      return tasks;
    }
    isLoading.value = false;
    return <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const Text(
                "Seems you have no events or tasks for today",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ClipRRect(
                child: Image.asset(
                  "assets/images/no_task.png",
                  // height: 250,
                  // width: 250,
                ),
              ),
              const Text("We will notify you once you have a task or an event"),
            ],
          ),
        ),
      ),
    ];
  }

  @override
  void onInit() {
    isLoading.value = false;
    super.onInit();
  }
}
