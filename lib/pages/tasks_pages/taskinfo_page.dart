import 'package:academia/controllers/taskmanager_controller.dart';
import 'package:academia/models/tasks.dart';
import 'package:academia/pages/tasks_pages/edittask_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskInformationPage extends StatelessWidget {
  final Task task;

  TaskInformationPage({Key? key, required this.task}) : super(key: key);
  final TaskManagerController taskmangagerController =
      Get.put(TaskManagerController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Information'), actions: [
        IconButton(
          onPressed: () {
            Get.defaultDialog(
              title: "Task Manager",
              content: const Text(
                  "This is the task manager. You can add tasks here and view them in the calendar."),
              textConfirm: "Got it!",
              confirmTextColor: Colors.white,
              onConfirm: () => Get.back(),
            );
          },
          icon: const Icon(Icons.info_rounded),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Obx(() => Text(
                  taskmangagerController.taskTitle.value,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w900),
                )),
            const SizedBox(height: 0),
            Obx(() => Text(
                  '${taskmangagerController.selectedUnit.value} - ${taskmangagerController.taskType.value}',
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                )),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            Row(children: [
              const Icon(Icons.calendar_today_rounded, size: 30),
              const SizedBox(width: 20),
              Obx(() => Text(
                    'Due ${DateFormat("yMMMMd").format((taskmangagerController.selectedDeadline.value))}',
                    style: const TextStyle(fontSize: 16),
                  ))
            ]),
            const SizedBox(height: 10),
            Row(children: [
              const Icon(Icons.punch_clock_rounded, size: 35),
              const SizedBox(width: 0),
              // Text(
              //   'Progress: ${task.progress}%',
              //   style: const TextStyle(fontSize: 16),
              // )
              Expanded(
                child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Obx(() => Text(
                                '${taskmangagerController.progress.value}% Complete',
                                // style: const TextStyle(fontSize: 16),
                              )),
                        ),
                        Slider(
                          value:
                              taskmangagerController.progress.value.toDouble(),
                          min: 0,
                          max: 100,
                          divisions: 10,
                          label: taskmangagerController.progress.value
                              .round()
                              .toString(),
                          onChanged: (double value) {
                            taskmangagerController
                                .updateTaskProgress(value.toInt());
                          },
                        ),
                      ],
                    )),
              )
            ]),
            const SizedBox(height: 10),
            const Divider(),
            Obx(() => Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      taskmangagerController.taskDescription.value,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                )),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // navigate to edit task page
                    Get.to(EditTaskPage(task: task));
                  },
                  child: const Text('Edit task'),
                ),
                const SizedBox(width: 10),
                TextButton(
                  onPressed: () {
                    // navigate to edit task page
                    Get.defaultDialog(
                      title: "Delete task?",
                      content: const Text(
                          "Are you sure you want to delete this task? This action cannot be undone."),
                      textConfirm: "Delete",
                      confirmTextColor: Colors.white,
                      onConfirm: () {
                        taskmangagerController.deleteTask(task);
                        Get.back();
                        Get.back();
                      },
                      textCancel: "Cancel",
                      onCancel: () => Get.back(),
                    );
                  },
                  child: const Text('Delete task'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
