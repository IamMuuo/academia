import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class FilledTodoHomeScreen extends StatelessWidget {
  const FilledTodoHomeScreen({super.key});

  Widget _buildFilteredTodos(String filter, List<Todo> todos) {
    return todos.isEmpty
        ? const EmptyTodoHomeScreen()
        : ListView.separated(
            itemBuilder: (context, index) {
              final data = todos[index];
              return TodoTile(todo: data);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 2),
            itemCount: todos.length);
  }

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
              () => TabBarView(children: [
                _buildFilteredTodos(
                    "today", todoController.filterTodosByDate("today")),
                _buildFilteredTodos(
                    "tommorrow", todoController.filterTodosByDate("tommorrow")),
                _buildFilteredTodos(
                    "week", todoController.filterTodosByDate("week")),
                _buildFilteredTodos(
                    "month", todoController.filterTodosByDate("month")),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
