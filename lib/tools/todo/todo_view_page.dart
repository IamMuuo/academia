import 'package:academia/exports/barrel.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

enum Mode {
  create,
  update,
}

class TodoViewPage extends StatefulWidget {
  const TodoViewPage({
    super.key,
    this.mode = Mode.create,
    this.todo,
  });
  final Mode mode;
  final Todo? todo;

  @override
  State<TodoViewPage> createState() => _TodoViewPageState();
}

class _TodoViewPageState extends State<TodoViewPage> {
  final todoController = Get.find<TodoController>();
  Color taskColor = Colors.green;
  final formState = GlobalKey<FormState>();
  final TextEditingController todoNameController = TextEditingController();
  final TextEditingController dueDateController = TextEditingController();
  final TextEditingController subTaskController = TextEditingController();
  DateTime dueDate = DateTime.now().add(const Duration(days: 1));

  String formatDateTime(DateTime dateTime) {
    return DateFormat('EEEE, d MMM y • H:mm a').format(dateTime);
  }

  Future<void> promptDueDate() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((selectedTime) {
          if (selectedTime != null) {
            setState(() {
              dueDate = DateTime(
                selectedDate.year,
                selectedDate.month,
                selectedDate.day,
                selectedTime.hour,
                selectedTime.minute,
              );
              dueDateController.text = formatDateTime(dueDate);
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formState,
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text("Task item"),
              actions: [],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: TextFormField(
                  controller: todoNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.length < 5) {
                      return "Please provide a memorable name for your task";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Your cool task",
                    suffixIcon: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Help"),
                            content: const Text(
                              "Please provide a short and memorable name for your task",
                            ),
                            actions: [
                              FilledButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"),
                              )
                            ],
                          ),
                        );
                      },
                      icon: const Icon(Ionicons.information_circle),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () async {
                    await ColorPicker(onColorChanged: (value) {
                      setState(() {
                        taskColor = value;
                      });
                    }).showPickerDialog(context);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: taskColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        "Select color to identify your task",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: TextFormField(
                  readOnly: true,
                  onTap: () async {
                    await promptDueDate();
                  },
                  controller: dueDateController,
                  decoration: InputDecoration(
                    hintText: "Due Date",
                    suffixIcon: IconButton(
                      onPressed: () async {
                        promptDueDate();
                      },
                      icon: const Icon(Ionicons.calendar),
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverFillRemaining(
                child: TextFormField(
                  controller: subTaskController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.length < 5) {
                      return "Please split your task into smaller tasks";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: const Text("Subtasks"),
                    hintText: "Split your tasks into smaller tasks",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.mode == Mode.create
            ? () {
                if (formState.currentState!.validate()) {
                  // add an item
                  todoController
                      .addTask(Todo(
                    due: dueDate,
                    name: todoNameController.text,
                    color: taskColor,
                    dateAdded: DateTime.now(),
                    complete: false,
                    description: subTaskController.text,
                  ))
                      .then((value) {
                    if (value) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Sucess"),
                          content: const Text(
                            "Your todo item has been sucessfully recorded",
                          ),
                          actions: [
                            FilledButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.of(context).pop();
                              },
                              child: const Text("Ok"),
                            )
                          ],
                        ),
                      );
                    }
                  });
                }
              }
            : () {},
        child: Icon(
          widget.mode == Mode.create ? Ionicons.add : Ionicons.trash,
        ),
      ),
    );
  }
}
