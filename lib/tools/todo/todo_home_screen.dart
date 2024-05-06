import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/todo/todo_view_page.dart';
import 'package:get/get.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final todoController = Get.find<TodoController>();
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
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    FilterChip.elevated(
                      label: const Text("Today"),
                      selected: true,
                      onSelected: (value) {},
                    ),
                    const SizedBox(width: 8),
                    FilterChip.elevated(
                      label: const Text("All"),
                      selected: false,
                      onSelected: (value) {},
                    ),
                    const SizedBox(width: 8),
                    FilterChip.elevated(
                      label: const Text("Tommorrow"),
                      selected: false,
                      onSelected: (value) {},
                    ),
                    const SizedBox(width: 8),
                    FilterChip.elevated(
                      label: const Text("This Week"),
                      selected: false,
                      onSelected: (value) {},
                    ),
                    const SizedBox(width: 8),
                    FilterChip.elevated(
                      label: const Text("This Month"),
                      selected: false,
                      onSelected: (value) {},
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: Obx(
                () => ListView.builder(
                  itemCount: todoController.todos.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(todoController.todos[index].name),
                  ),
                ),
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
