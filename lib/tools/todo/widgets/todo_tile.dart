import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import '../todo_view_page.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({super.key, required this.todo});
  final Todo todo;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  final TodoController todoController = Get.find<TodoController>();
  double calculatePercent() {
    final subtasksCount = widget.todo.subTasks?.values.length ?? 0;
    if (subtasksCount == 0) {
      return 0;
    }
    final done = widget.todo.subTasks!.values
        .where((val) => val == true)
        .toList()
        .length;
    return (done / subtasksCount);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => TodoViewPage(
                  todo: widget.todo,
                )));
      },
      leading: Checkbox(
          value: widget.todo.complete,
          onChanged: (value) {
            setState(() {
              widget.todo.complete = value!;
              todoController.updateTodo(
                widget.todo..dateCompleted = DateTime.now(),
              );
            });
          }),
      title: Text(
        widget.todo.name,
        style: widget.todo.complete
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      ),
      subtitle: LinearProgressIndicator(
        value: calculatePercent(),
      ),
      trailing: IconButton(
        onPressed: () async {
          final deleted = await todoController.deleteTodo(widget.todo);
          if (deleted && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Todo has been sucessfully deleted")),
            );
            return;
          }
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    "Something went wrong while trying to delete todo try again")),
          );
        },
        icon: const Icon(Ionicons.trash),
      ),
    );
  }
}
