import '../todo.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TodoItemCard extends StatelessWidget {
  const TodoItemCard({
    super.key,
    required this.todo,
    required this.ontap,
  });
  final Todo todo;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(8),
        border: Border.all(
          width: 2,
        ),
      ),
      child: ListTile(
        title: Row(
          children: [
            Checkbox(
              value: todo.complete,
              onChanged: (value) {
                ontap();
              },
            ),
            const SizedBox(width: 2),
            Text(todo.name),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(trimAndEllipsis(todo.description, 7)),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Ionicons.calendar_outline),
                Text(
                  " ${formatDateTime(todo.due)}",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
