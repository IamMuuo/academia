import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/todo/todo_view_page.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class FilledTodoHomeScreen extends StatefulWidget {
  const FilledTodoHomeScreen({super.key});

  @override
  State<FilledTodoHomeScreen> createState() => _FilledTodoHomeScreenState();
}

class _FilledTodoHomeScreenState extends State<FilledTodoHomeScreen> {
  late List<Todo> todos;
  late List<Todo> filteredTodos;
  final todoController = Get.find<TodoController>();

  final filterItems = <String, bool>{
    "today": true,
    "all": false,
    "tomorrow": false,
    "week": false,
    "month": false,
  };

  // List<Todo> filterTodosByDate(String filterOption) {
  //   todos = todoController.allTodos;
  //   final today = DateTime.now();
  //   final tomorrow = DateTime.now().add(const Duration(days: 1));
  //   switch (filterOption.toLowerCase().trim()) {
  //     case "today":
  //       return todos
  //           .where((element) =>
  //               element.due.day == today.day &&
  //               element.due.month == today.month &&
  //               element.due.year == today.year)
  //           .toList(growable: false);
  //
  //     case "tomorrow":
  //       return todos
  //           .where((element) =>
  //               element.due.day == tomorrow.day &&
  //               element.due.month == tomorrow.month &&
  //               element.due.year == tomorrow.year)
  //           .toList(growable: false);
  //
  //     case "month":
  //       return todos
  //           .where((element) =>
  //               element.due.day < 31 &&
  //               element.due.month == today.month &&
  //               element.due.year == today.year)
  //           .toList(growable: false);
  //
  //     default:
  //       return todos;
  //   }
  // }
  //
  @override
  void initState() {
    todos = todoController.allTodos;
    filteredTodos = todos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Tasker"),
            floating: true,
            snap: true,
            pinned: true,
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Feature"),
                      content: const Text(
                        "Tasker helps you keep track of assignments and todo stuff",
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
          ),
          SliverToBoxAdapter(
            child: TodoHeatMap(todos: todoController.allTodos),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filterItems.keys.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: FilterChip.elevated(
                    selected: filterItems.values.elementAt(index),
                    label: Text(
                        filterItems.keys.elementAt(index).toString().title()),
                    onSelected: (value) {
                      filterItems.forEach(
                        (key, _) => filterItems[key] = false,
                      );
                      if (!value) {
                        filterItems["today"] = true;
                      }

                      setState(
                        () {
                          filterItems[filterItems.keys.elementAt(index)] =
                              value;
                          filteredTodos = todoController.filterTodosByDate(
                              filterItems.keys.elementAt(index));
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SliverSafeArea(
            minimum: const EdgeInsets.all(12),
            sliver: SliverFillRemaining(
              child: filteredTodos.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/lotties/empty.json"),
                        Text(
                          "No todo items for the specified period",
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final todo = filteredTodos[index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TodoViewPage(
                                      todo: todo,
                                      mode: Mode.update,
                                    )));
                          },
                          child: TodoItemCard(
                              todo: todo,
                              ontap: () {
                                setState(() {
                                  todoController.updateTodo(todo);
                                });
                              }),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 8),
                      itemCount: filteredTodos.length,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
