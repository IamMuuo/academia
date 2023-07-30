import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    this.taskName,
    this.taskDate = "chrismass",
    this.taskTime,
  });
  final String? taskName;
  final String? taskDate;
  final String? taskTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(8),
        trailing: IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.delete_solid,
              color: Colors.red,
            )),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        tileColor: Colors.white,
        // contentPadding: const EdgeInsets.all(8),
        subtitle:
            Text("${taskName!} is scheduled for ${taskDate!} at ${taskTime!}"),
        leading: Icon(
          CupertinoIcons.bell_fill,
          color: Colors.blue[300],
          size: 30,
        ),
        title: Text(
          taskName!,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
