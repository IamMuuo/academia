import 'dart:convert';

import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';
import 'package:drift/drift.dart' as drift;
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sliver_tools/sliver_tools.dart';

enum TodoEditState {
  create,
  modify,
}

class TodoViewPage extends StatefulWidget {
  const TodoViewPage({super.key, this.todoData});
  final TodoData? todoData;

  @override
  State<TodoViewPage> createState() => _TodoViewPageState();
}

class _TodoViewPageState extends State<TodoViewPage> {
  late CourseCubit courseCubit = BlocProvider.of<CourseCubit>(context);
  late TodoEditState editState =
      widget.todoData == null ? TodoEditState.create : TodoEditState.modify;

  late TodoData todo;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Map<String, bool>? subtasks;

  @override
  void initState() {
    todo = widget.todoData == null
        ? TodoData(
            userId: "",
            title: "",
            body: "",
            notify: false,
            complete: false,
            autocomplete: false,
            dateCreated: DateTime.now(),
            dateModified: DateTime.now(),
            completedAt: DateTime.now())
        : widget.todoData!;

    _titleController.text = todo.title;
    _descriptionController.text = todo.body;
    subtasks = todo.subtasks == null ? {} : json.decode(todo.subtasks!);

    super.initState();
  }

  void _showAddSubtaskDialog() {
    final TextEditingController subTaskController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            Text(
              "Please add a subtask to your todo",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextFormField(
              controller: subTaskController,
              decoration: InputDecoration(
                hintText: "Remember to...",
                hintStyle: Theme.of(context).textTheme.titleMedium,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
              ),
            ),
            FilledButton(
              onPressed: () {
                setState(() {
                  subtasks![subTaskController.text.capitalize] = false;
                });
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Subtask sucessfully added to task"),
                  ),
                );
              },
              child: const Text(
                "Add sub task",
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _configureDueDate() async {
    final picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );
    if (picked != null) {
      setState(() {
        todo = todo.copyWith(duedate: drift.Value(picked));
      });
    }
  }

  Future<void> _configureNotificationTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        todo = todo.copyWith(
          notifyAt: drift.Value(
            DateTime.now().copyWith(
              hour: picked.hour,
              minute: picked.minute,
            ),
          ),
        );
      });
    }
  }

  Future<void> _showCoursePickerDialog() async {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CourseCubit, CourseState>(builder: (context, state) {
          if (state is! CourseStateLoaded) {
            return const Center(
              child: Text("Please refresh courses to continue"),
            );
          }

          final courses = (state).courses;
          return ListView.builder(
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                    title: Text(courses[index].unit),
                    value: false,
                    onChanged: (val) {
                      setState(() {
                        todo = todo.copyWith(
                            unit: drift.Value(courses[index].unit));
                      });
                      context.pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Successfully linked task to ${courses[index].unit}"),
                        ),
                      );
                    });
              });
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            expandedHeight: 128,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                editState == TodoEditState.create
                    ? "Create a todo item"
                    : "Modify todo",
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: MultiSliver(
              children: [
                SliverPinnedHeader(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: TextFormField(
                      controller: _titleController,
                      maxLength: 30,
                      decoration: InputDecoration(
                        hintText: "Tap to add a title",
                        hintStyle:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPinnedHeader(
                  child: Text(
                    "Add some sub-tasks 🫠",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                SliverList.builder(
                  itemBuilder: (context, index) {
                    if (index == subtasks!.keys.length) {
                      return TextButton.icon(
                        onPressed: _showAddSubtaskDialog,
                        icon: const Icon(Bootstrap.journal_plus),
                        label: const Text("Add a subtask"),
                      );
                    }
                    var item = subtasks!.entries.elementAt(index);
                    return CheckboxListTile(
                      onChanged: (value) {
                        setState(() {
                          subtasks![item.key] = value!;
                        });
                      },
                      value: item.value,
                      title: Text(item.key),
                    );
                  },
                  itemCount: subtasks!.keys.length + 1,
                ),
                const SizedBox(height: 16),
                SliverPinnedHeader(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    color: Theme.of(context).colorScheme.surface,
                    child: Text(
                      "More task configurations",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 2),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                    ),
                    child: ListTile(
                      onTap: () async {
                        final color = await showColorPickerDialog(
                          context,
                          Theme.of(context).colorScheme.primary,
                        );

                        setState(() {
                          todo = todo.copyWith(color: drift.Value(color.value));
                        });
                      },
                      title: const Text("Pick a color for this task"),
                      leading: CircleAvatar(
                        backgroundColor:
                            todo.color == null ? null : Color(todo.color!),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 2),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: ListTile(
                      leading: const Icon(Bootstrap.calendar_day),
                      enableFeedback: true,
                      onTap: () async {
                        await _configureDueDate();
                        await HapticFeedback.heavyImpact();
                      },
                      title: const Text("Pick due date for task"),
                      subtitle: Text(
                        todo.duedate == null
                            ? "Not configured yet"
                            : todo.duedate.toString(),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 2),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: ListTile(
                      leading: const Icon(Bootstrap.vinyl),
                      enableFeedback: false,
                      onTap: () {
                        _showCoursePickerDialog();
                        HapticFeedback.heavyImpact().then((value) {});
                      },
                      title: const Text("Pick a course for this task"),
                      subtitle: todo.unit == null ? null : Text(todo.unit!),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 2),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: SwitchListTile(
                      enableFeedback: true,
                      onChanged: (val) {
                        HapticFeedback.heavyImpact().then((value) {
                          setState(() {
                            todo = todo.copyWith(complete: val);
                          });
                        });
                      },
                      value: todo.complete,
                      title: const Text("Mark task as complete"),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 2),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: SwitchListTile(
                      enableFeedback: true,
                      onChanged: (val) {
                        HapticFeedback.heavyImpact().then((value) {
                          setState(() {
                            todo = todo.copyWith(autocomplete: val);
                          });
                        });
                      },
                      value: todo.autocomplete,
                      title: const Text("Automatically close this task"),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 2),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    child: SwitchListTile(
                      enableFeedback: false,
                      onChanged: (val) {
                        HapticFeedback.heavyImpact().then((value) {
                          setState(() {
                            todo = todo.copyWith(notify: val);
                          });
                        });
                      },
                      value: todo.notify,
                      title: const Text("Notify me on this task"),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Card(
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 2),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(12),
                      ),
                    ),
                    child: ListTile(
                      enabled: todo.notify,
                      onTap: () async {
                        await _configureNotificationTime();
                      },
                      title: const Text("Configure task's notification"),
                      leading: const Icon(Bootstrap.bell),
                      subtitle: const Text(
                        "Notifications will automatically repeat on the specified time until completed or deleted",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Bootstrap.check),
      ),
    );
  }
}
