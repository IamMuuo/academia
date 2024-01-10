import 'package:academia/controllers/taskmanager_controller.dart';
import 'package:academia/pages/tasks_pages/newtask_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskManagerPage extends StatelessWidget {
  TaskManagerPage({super.key});
  final TaskManagerController taskManagerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      taskManagerController.getTasks();
      final tasks = taskManagerController.tasks;

      return Scaffold(
          appBar: AppBar(
            title: Text("Task Manager"),
          ),
          body: // Check if there are any tasks
              tasks.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.task, size: 100),
                          Text("No tasks yet"),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          title: Text(tasks[index].title ?? ''),
                          subtitle: Text(tasks[index].description ?? ''),
                          trailing: Column(
                            children: [
                              Text(
                                DateFormat("dd/MM/yyyy").format(
                                    (tasks[index].deadline ?? DateTime.now())),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${tasks[index].progress}%",
                              )
                            ],
                          ),
                          onTap: () {
                            taskManagerController.updateTask(
                                tasks[index].type ?? '',
                                tasks[index].title ?? '',
                                tasks[index].description ?? '',
                                tasks[index].unit ?? '',
                                tasks[index].deadline ?? DateTime.now(),
                                tasks[index].progress ?? 0);
                            Get.to(() => NewTaskPage());
                          },
                        ));
                      },
                    ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => NewTaskPage());
            },
            child: const Icon(Icons.add),
          ));
    });
  }
}
