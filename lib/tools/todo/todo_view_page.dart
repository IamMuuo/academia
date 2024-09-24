import 'package:academia/exports/barrel.dart';
import 'package:academia/notifier/local_notification_channel.dart';
import 'package:academia/notifier/notifier.dart';
import 'package:get/get.dart';

class TodoViewPage extends StatefulWidget {
  const TodoViewPage({super.key, this.todo});
  final Todo? todo;

  @override
  State<TodoViewPage> createState() => _TodoViewPageState();
}

class _TodoViewPageState extends State<TodoViewPage> {
  final TodoController todoController = Get.find<TodoController>();
  final NotificationsController notificationsController =
      Get.find<NotificationsController>();
  final Map<String, bool> subtasks = {};
  final TextEditingController titleController = TextEditingController();
  final TextEditingController duedateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController subTaskController = TextEditingController();
  bool notify = false;
  late DateTime dueDate;
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  Future<void> pickDueDate() async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    if (date != null) {
      setState(() {
        dueDate = date;
        duedateController.text = (formatDateTime(date));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      // subtasks = widget.todo.subTasks ?? {};
      titleController.text = widget.todo!.name;
      descriptionController.text = widget.todo!.description;
      duedateController.text = formatDateTime(widget.todo!.due);
      dueDate = widget.todo!.due;
      notify = widget.todo!.notify;
      subtasks.addAll(widget.todo!.subTasks ?? {});
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formState,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: true,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  widget.todo == null ? "Create a todo" : "Update todo",
                ),
              ),
            ),

            // body
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: TextFormField(
                  controller: titleController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value!.length < 5
                      ? "Please provide a valuable title"
                      : null,
                  style: Theme.of(context).textTheme.titleMedium,
                  decoration: const InputDecoration(
                    hintText: "Your awesome task name",
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: TextFormField(
                  onTap: () async => await pickDueDate(),
                  controller: duedateController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      value!.length < 5 ? "Please pick a date" : null,
                  style: Theme.of(context).textTheme.titleMedium,
                  decoration: const InputDecoration(
                    hintText: "Due Date",
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: Row(
                  children: [
                    Checkbox(
                      value: notify,
                      onChanged: (value) {
                        setState(() {
                          notify = value!;
                        });
                      },
                    ),
                    const Text("Notify me everyday on this task"),
                  ],
                ),
              ),
            ),

            // Task description
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: TextFormField(
                  controller: descriptionController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value!.length < 5
                      ? "Please provide a description for your task"
                      : null,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Describe your task",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),

            // Split them to subtasks
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Split your tasks into subtasks",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),

            // Now for the sub taks
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList.separated(
                itemBuilder: (context, index) {
                  return index == subtasks.length
                      ? TextButton.icon(
                          icon: const Icon(Ionicons.add),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller: subTaskController,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (value) => value!
                                                        .length <
                                                    5
                                                ? "Please provide a description for your task"
                                                : null,
                                            decoration: const InputDecoration(
                                              hintText: "Sub tasks name",
                                            ),
                                          ),
                                          const SizedBox(height: 22),
                                          FilledButton(
                                              onPressed: () {
                                                if (subTaskController
                                                    .text.isNotEmpty) {
                                                  setState(() {
                                                    subtasks.addAll({
                                                      subTaskController.text:
                                                          false
                                                    });
                                                    subTaskController.text = "";
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: const Text("Add"))
                                        ],
                                      ),
                                    ));
                          },
                          label: const Text("Add Subtask"),
                        )
                      : ListTile(
                          title: Text(
                            subtasks.keys.elementAt(index).title(),
                          ),
                          leading: Checkbox(
                              value: subtasks.values.elementAt(index),
                              onChanged: (val) {
                                setState(() {
                                  subtasks[subtasks.keys.elementAt(index)] =
                                      val!;
                                });
                              }),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                subtasks.remove(subtasks.keys.elementAt(index));
                              });
                            },
                            icon: const Icon(Ionicons.trash),
                          ),
                        );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 2),
                itemCount: subtasks.length + 1,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.todo == null
            ? () async {
                if (!formState.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please ensure you fill the form"),
                  ));
                  return;
                }

                // Add the data to the controller
                final ok = await todoController.addTask(
                  Todo(
                      subTasks: subtasks,
                      name: titleController.text,
                      description: descriptionController.text,
                      dateAdded: DateTime.now(),
                      due: dueDate,
                      notify: notify,
                      complete: false),
                );

                if (ok) {
                  if (!context.mounted) return;
                  if (notify) {
                    // notification logic
                    LocalNotifierService().showNotification(
                      id: LocalNotificationStatusManager().getNextId(),
                      title: "Todos",
                      body:
                          "Todo ${titleController.text} has been scheduled successfully",
                      channelKey:
                          LocalNotificationChannelType.reminders.channelKey,
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      notify
                          ? "Your task has been saved and you will be notified daily"
                          : "Your task has been sucessfully saved",
                    ),
                  ));
                  return;
                }
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      "Something went wrong while trying to save your todo"),
                ));
                return;
              }
            : () async {
                if (!formState.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please ensure you fill the form"),
                  ));
                  return;
                }

                widget.todo?.name = titleController.text;
                widget.todo?.description = descriptionController.text;
                widget.todo?.subTasks = subtasks;
                widget.todo?.due = dueDate;
                widget.todo?.notify = notify;

                final ok = await todoController.updateTodo(widget.todo!);
                if (ok) {
                  if (!context.mounted) return;
                  if (notify) {
                    // notification logic
                    LocalNotifierService().showNotification(
                      id: LocalNotificationStatusManager().getNextId(),
                      title: "Todos",
                      body:
                          "Todo ${titleController.text} has been scheduled successfully",
                      channelKey:
                          LocalNotificationChannelType.reminders.channelKey,
                    );
                  }

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      "Your task has been sucessfully updated",
                    ),
                  ));
                  return;
                }
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                    "Something went wrong while attempting to update todo",
                  ),
                ));
              },
        child: const Icon(Ionicons.checkmark),
      ),
    );
  }
}
