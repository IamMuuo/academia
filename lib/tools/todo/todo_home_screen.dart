import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/todo/todo_view_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final filterItems = <String, bool>{
    "today": true,
    "all": false,
    "tommorrow": false,
    "week": false,
    "month": false,
  };

  final todoController = Get.find<TodoController>();
  @override
  void initState() {
    todos = todoController.filterTodosByDate("today");
    super.initState();
  }

  List<Todo> todos = <Todo>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 4),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text("Agenda"),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Ionicons.menu)),
              ],
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
                            todos = todoController.filterTodosByDate(
                                filterItems.keys.elementAt(index));
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: todos.isNotEmpty
                  ? ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) => TodoItemCard(
                        todo: todos[index],
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Wow you have nothing here yet ${Emojis.smile_face_with_raised_eyebrow}",
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TodoViewPage(),
            ),
          );
        },
        child: const Icon(Ionicons.add),
      ),
    );
  }
}

class TodoItemCard extends StatelessWidget {
  const TodoItemCard({super.key, required this.todo});
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    final todoController = Get.find<TodoController>();
    final DateFormat format = DateFormat('E MMM d, y');
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(
          todo.name,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                decoration: todo.complete ? TextDecoration.lineThrough : null,
              ),
        ),
        trailing: IconButton(
          icon: const Icon(Ionicons.grid_outline),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      title: const Text("Mark as complete"),
                      leading: const Icon(Ionicons.checkmark_outline),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    ListTile(
                      title: const Text("Edit"),
                      leading: const Icon(Ionicons.create_outline),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const TodoViewPage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: const Text("Delete"),
                      leading: const Icon(Ionicons.trash_outline),
                      onTap: () {
                        todoController
                            .deleteTodo(todo.id!)
                            .then((value) => value);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Ionicons.calendar_outline,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  format.format(todo.date),
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(int.parse(todo.color)),
                  radius: 8,
                ),
                const SizedBox(width: 8),
                Text(
                  todo.description.length > 10
                      ? "${todo.description.substring(0, 9)} ..."
                      : todo.description,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
