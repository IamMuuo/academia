import 'package:academia/controllers/taskmanager_controller.dart';
import 'package:academia/models/tasks.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditTaskPage extends StatelessWidget {
  EditTaskPage({Key? key, required this.task}) : super(key: key);
  final TaskManagerController taskManagerController =
      Get.put(TaskManagerController());
  final Task task;
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    taskTitleController.text = task.title!;
    taskDescriptionController.text = task.description!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close),
        ),
        title: const Text("Edit Task"),
        actions: [
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                TextButtonTheme(
                  data: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blueGrey,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      taskManagerController.loadRegisteredUnits();
                      if (taskManagerController.coursesList.isEmpty) {
                        debugPrint("Empty");
                      }
                      for (final course in taskManagerController.coursesList) {
                        debugPrint(course.name);
                      }
                      Get.bottomSheet(
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Text("List of units",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 300,
                                  child: ListView.builder(
                                    itemCount: taskManagerController
                                        .coursesList.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(taskManagerController
                                            .coursesList[index].name),
                                        onTap: () {
                                          taskManagerController.updateUnit(
                                              taskManagerController
                                                  .coursesList[index].name);
                                          Get.back();
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          barrierColor: Colors.transparent,
                          backgroundColor: Colors.white);
                    },
                    child: Row(
                      children: [
                        Obx(() => Text(
                            "Unit: ${taskManagerController.selectedUnit.value}")),
                        const SizedBox(width: 8),
                        const Icon(
                            IconData(0xe098, fontFamily: 'MaterialIcons')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                TextButtonTheme(
                  data: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blueGrey,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.bottomSheet(
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                const Text("Task types",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    )),
                                SizedBox(
                                  height: 300,
                                  child: ListView.builder(
                                    itemCount:
                                        taskManagerController.taskTypes.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        title: Text(taskManagerController
                                            .taskTypes[index]),
                                        onTap: () {
                                          taskManagerController.updateTaskType(
                                              taskManagerController
                                                  .taskTypes[index]);
                                          Get.back();
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          barrierColor: Colors.transparent, // Add this line
                          backgroundColor: Colors.white);
                    },
                    child: Row(
                      children: [
                        Obx(() => Text(
                            "Task Type: ${taskManagerController.taskType.value}")),
                        const SizedBox(width: 8),
                        const Icon(
                            IconData(0xe098, fontFamily: 'MaterialIcons')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                TextButtonTheme(
                  data: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blueGrey,
                    ),
                  ),
                  child: TextButton(
                    child: Obx(() => Text(
                        'Deadline: ${DateFormat('yyyy-MM-dd').format(taskManagerController.selectedDeadline.value)}')),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          taskManagerController.updateDeadline(selectedDate);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: "Task title",
              ),
              controller: taskTitleController,
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: const InputDecoration(
                hintText: "Task description",
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              controller: taskDescriptionController,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                taskManagerController.editTask(
                    taskTitleController.text,
                    taskDescriptionController.text,
                    taskManagerController.taskType.value,
                    taskManagerController.selectedUnit.value.toString(),
                    taskManagerController.selectedDeadline.value,
                    task.progress ?? 0);

                Get.back();
                Get.snackbar("Task Edit", "Task has been edited successfully!");
              },
              child: const Text("Edit task"),
            ),
          ],
        ),
      ),
    );
  }
}
