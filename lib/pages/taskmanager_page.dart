import 'package:academia/controllers/taskmanager_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskManagerPage extends StatelessWidget {
  TaskManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Task Manager"),
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.task, size: 100),
              Text("No tasks yet"),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(NewTaskPage());
          },
          child: const Icon(Icons.add),
        ));
  }
}

class NewTaskPage extends StatelessWidget {
  NewTaskPage({super.key});
  final TaskManagerController taskManagerController =
      Get.put(TaskManagerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close),
        ),
        title: const Text("New Task"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text("Save",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0), fontSize: 16)),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
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
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Text("Select Course"),
                        SizedBox(width: 8),
                        Icon(IconData(0xe098, fontFamily: 'MaterialIcons')),
                      ],
                    ),
                  ),
                ),
                TextButtonTheme(
                  data: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.blueGrey,
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Row(
                      children: [
                        Text("Select Task Type"),
                        SizedBox(width: 8),
                        Icon(IconData(0xe098, fontFamily: 'MaterialIcons')),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              child: Obx(() => Text(
                  'Selected date: ${DateFormat('yyyy-MM-dd').format(taskManagerController.selectedDate.value)}')),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(Duration(days: 365)),
                ).then((selectedDate) {
                  if (selectedDate != null) {
                    taskManagerController.updateDate(selectedDate);
                  }
                });
              },
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                hintText: "Task title",
              ),
            ),
            const SizedBox(height: 8),
            const TextField(
              decoration: InputDecoration(
                hintText: "Task description",
              ),
              keyboardType: TextInputType.multiline,
              maxLines: 4,
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
