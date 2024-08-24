import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class TodoItemSection extends StatefulWidget {
  const TodoItemSection({super.key});

  @override
  State<TodoItemSection> createState() => _TodoItemSectionState();
}

class _TodoItemSectionState extends State<TodoItemSection> {
  final todoController = Get.find<TodoController>();
  late List<Todo> allTodos;

  List<Todo> getDueTodos() {
    DateTime now = DateTime.now();

    List<Todo> dueTodos = todoController.allTodos
        .where((todo) => !todo.complete && todo.due.isAfter(now))
        .toList();

    dueTodos.sort((a, b) => a.due.compareTo(b.due));

    return dueTodos;
  }

  @override
  void initState() {
    super.initState();
    allTodos = todoController.allTodos;
    // allTodos = _getDueTodos();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      sliver: SliverFillRemaining(
        child: ListView.separated(
          itemBuilder: (context, index) {
            final currentTodo = allTodos[index];
            return GestureDetector(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Confirmation"),
                    content: const Text("Are you sure you want to delete? "),
                    actions: [
                      FilledButton(
                        onPressed: () {
                          HapticFeedback.heavyImpact().then((value) {
                            todoController
                                .deleteTodo(currentTodo)
                                .then((value) {
                              if (!context.mounted) return;
                              if (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Task deleted successfully"),
                                  ),
                                );
                                allTodos.remove(allTodos);
                                setState(() {});

                                Navigator.pop(context);
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Failed to delete task"),
                                ),
                              );
                            });
                          });
                        },
                        child: const Text("Sure"),
                      ),
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                    ],
                  ),
                );
              },
              child: TodoItemCard(
                todo: currentTodo,
                ontap: () {
                  HapticFeedback.heavyImpact().then((value) {
                    todoController.updateTodo(currentTodo);
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Task updated sucessfully"),
                      ),
                    );
                    setState(() {});
                  });
                },
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(height: 8);
          },
          itemCount: allTodos.length,
        ),
      ),
    );
  }
}
