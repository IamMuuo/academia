import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/todo/todo_view_page.dart';
import 'package:get/get.dart';

class FilledTodoHomeScreen extends StatelessWidget {
  const FilledTodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.find<TodoController>();

    return DefaultTabController(
      length: 4,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            title: const Text("Todos"),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Feature"),
                      content: const Text(
                        "Todos helps you keep track of assignments and todo stuff",
                      ),
                      actions: [
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Ok cool"),
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(Ionicons.information_circle_outline),
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(text: "Today"),
                Tab(text: "Tommorrow"),
                Tab(text: "Week"),
                Tab(text: "Month"),
              ],
            ),
          ),
          SliverFillRemaining(
            child: Obx(
              () => todoController.allTodos.isEmpty
                  ? Column(
                      children: [
                        Text(
                          "Theres nothing here yet, create a todo to get started",
                          style: Theme.of(context).textTheme.headlineMedium,
                        )
                      ],
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final todo = todoController.allTodos[index];
                        return TodoTile(todo: todo);
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 2),
                      itemCount: todoController.allTodos.length,
                    ),
            ),
          )
        ],
      ),
    );
  }
}

class TodoTile extends StatefulWidget {
  const TodoTile({super.key, required this.todo});
  final Todo todo;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
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
        onPressed: () {},
        icon: const Icon(Ionicons.trash),
      ),
    );
  }
}
