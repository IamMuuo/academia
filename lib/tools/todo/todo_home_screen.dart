import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/todo/todo_view_page.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agenda"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Ionicons.menu)),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          children: [
            SizedBox(
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
