import 'package:academia/exports/barrel.dart';
import 'package:intl/intl.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

class TodoViewPage extends StatefulWidget {
  const TodoViewPage({super.key});

  @override
  State<TodoViewPage> createState() => _TodoViewPageState();
}

class _TodoViewPageState extends State<TodoViewPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _notificationTime;
  Color? _selectedColor;
  bool _completed = false;
  bool _selectedFrequency = false;

  final formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('EEEE, MMM yyyy');
  final DateFormat timeformatter = DateFormat('HH:mm');

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime(2030))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
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
      builder: (context) => AlertDialog(
        title: const Text("Notification Frequency"),
        actions: [
          FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                _presentTimePicker();
              },
              child: const Text("Confirm")),
          FilledButton.tonal(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel")),
        ],
        content: StatefulBuilder(
          builder: (context, StateSetter setState) {
            return SizedBox(
              height: 150,
              child: Column(
                children: [
                  RadioListTile<bool>(
                    title: const Text("Every Day"),
                    value: true,
                    groupValue:
                        _selectedFrequency, // Assuming you have a variable to hold the selected frequency
                    onChanged: (bool? value) {
                      setState(() {
                        _selectedFrequency = value!;
                      });
                    },
                  ),
                  RadioListTile<bool>(
                    title: const Text("Day Before"),
                    value: false,
                    groupValue:
                        _selectedFrequency, // Assuming you have a variable to hold the selected frequency
                    onChanged: (bool? value) {
                      setState(() {
                        _selectedFrequency = value!;
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _presentColorPicker() {
    ColorPicker(
      color: Colors.teal,
      onColorChanged: (Color color) {
        setState(() {
          _selectedColor = color;
        });
      },
    ).showPickerDialog(
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agenda Item"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Ionicons.trash)),
          IconButton(onPressed: () {}, icon: const Icon(Ionicons.save_outline)),
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
                TextFormField(
                  controller: titleController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if ((value?.length ?? 0) < 3) {
                      return "Please specify a valid title";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Add agenda title",
                    hintStyle: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: Colors.grey),
                    border: InputBorder.none,
                  ),
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
                      _selectedFrequency
                          ? "Every day to that day"
                          : "Just day before",
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
                    onTap: () {
                      _presentColorPicker();
                    },
                    leading: CircleAvatar(
                      radius: 10,
                      backgroundColor: _selectedColor == null
                          ? Colors.teal
                          : _selectedColor!,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if ((value?.length ?? 0) < 5) {
                        return "Please describe this task to make it memorable";
                      }
                      return null;
                    },
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
                const Divider(height: 20),
                FilledButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    _completed ? Ionicons.pricetag_outline : Ionicons.checkmark,
                  ),
                  label: Text(
                    _completed ? "Umark as complete" : "Mark as complete",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
