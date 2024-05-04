import 'package:academia/exports/barrel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoViewPage extends StatefulWidget {
  const TodoViewPage({super.key});

  @override
  State<TodoViewPage> createState() => _TodoViewPageState();
}

enum _NotificationFrequency {
  everyDay,
  dayBefore,
}

class _TodoViewPageState extends State<TodoViewPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _notificationTime;

  final formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('EEEE, MMM yyyy');
  final DateFormat timeformatter = DateFormat('HH:mm');

  void _presentDatePicker() {
    // showDatePicker is a pre-made funtion of Flutter
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030))
        .then((pickedDate) {
      // Check if no date is selected
      if (pickedDate == null) {
        return;
      }
      setState(() {
        // using state so that the UI will be rerendered when date is picked
        _selectedDate = pickedDate;
      });
    });
  }

  void _presentTimePicker() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _notificationTime = value;
      });
    });
  }

  void _presentFrequencyPicker() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Reminder Frequency"),
            children: <Widget>[
              SimpleDialogOption(
                child: Text("Every Day"),
                onPressed: () {},
              ),
              SimpleDialogOption(
                child: Text("Every Day"),
                onPressed: () {},
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agenda Item"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Ionicons.save_outline))
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Ionicons.close_outline),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Radio(
                      value: false,
                      groupValue: "Completed",
                      onChanged: (value) {},
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: titleController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if ((value?.length ?? 0) < 3) {
                            return "Please specify a valid title";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Add task name",
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: Colors.grey),
                          border: InputBorder.none,
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    onTap: () {
                      _presentDatePicker();
                    },
                    leading: const Icon(Ionicons.calendar_outline),
                    title: Text(
                      _selectedDate == null
                          ? "Select Date"
                          : formatter.format(_selectedDate!),
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    onTap: () {
                      _presentFrequencyPicker();
                      // _presentTimePicker();
                    },
                    leading: const Icon(Ionicons.notifications_outline),
                    title: Text(
                      "Remind me at ${_notificationTime == null ? '16:00' : _notificationTime!.format(context)}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      "Day before",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.grey),
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    onTap: () {},
                    leading: const CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                    ),
                    title: Text(
                      "Pick a color",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: noteController,
                    maxLines: 7,
                    decoration: InputDecoration(
                      hintText: "Add a note",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
