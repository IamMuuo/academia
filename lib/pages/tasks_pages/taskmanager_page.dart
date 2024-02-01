import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TaskManagerPage extends StatelessWidget {
  TaskManagerPage({super.key});
  final TaskManagerController taskManagerController = Get.find();

  @override
  Widget build(BuildContext context) {
    taskManagerController.getTasks();
    final tasks = taskManagerController.tasks;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text("Task Manager"),
          bottom: TabBar(
            controller: taskManagerController.tabController,
            tabs: taskManagerController.tabs,
            labelColor: Colors.white,
          ),
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
        body: // Check if there are any tasks
            TabBarView(
          controller: taskManagerController.tabController,
          children: [
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
                    itemCount:
                        tasks.where((task) => task.progress < 100).length,
                    itemBuilder: (context, index) {
                      Task task = tasks
                          .where((task) => task.progress < 100)
                          .toList()[index];
                      return Card(
                        child: ListTile(
                          title: Text(task.title ?? ''),
                          subtitle: Text(task.unit ?? ''),
                          trailing: Column(
                            children: [
                              Text(
                                DateFormat("dd/MM/yyyy")
                                    .format((task.deadline ?? DateTime.now())),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${task.progress}%",
                              )
                            ],
                          ),
                          onTap: () {
                            taskManagerController.updateTask(
                              task.type ?? '',
                              task.title ?? '',
                              task.description ?? '',
                              task.unit ?? '',
                              task.deadline ?? DateTime.now(),
                              task.progress ?? 0,
                            );
                            Get.to(() => TaskInformationPage(
                                  task: task,
                                ));
                          },
                        ),
                      );
                    },
                  ),
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
                    itemCount:
                        tasks.where((task) => task.progress == 100).length,
                    itemBuilder: (context, index) {
                      Task task = tasks
                          .where((task) => task.progress == 100)
                          .toList()[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                            task.title ?? '',
                            style: const TextStyle(
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          subtitle: Text(task.unit ?? ''),
                          trailing: Column(
                            children: [
                              Text(
                                DateFormat("dd/MM/yyyy")
                                    .format((task.deadline ?? DateTime.now())),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${task.progress}%",
                              )
                            ],
                          ),
                          onTap: () {
                            taskManagerController.updateTask(
                                task.type ?? '',
                                task.title ?? '',
                                task.description ?? '',
                                task.unit ?? '',
                                task.deadline ?? DateTime.now(),
                                task.progress ?? 0);
                            Get.to(() => TaskInformationPage(
                                  task: task,
                                ));
                          },
                        ),
                      );
                    },
                  ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            taskManagerController.clearTaskManager();
            Get.to(() => NewTaskPage());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
