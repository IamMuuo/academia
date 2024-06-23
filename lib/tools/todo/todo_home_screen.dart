import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/todo/todo_view_page.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final todoController = Get.find<TodoController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text("Tasker"),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Clarification"),
                      content: const Text(
                        "Keep track of your assignments and todo items in a secure way, tasks you add here never leave your device",
                      ),
                      actions: [
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Wow, cool feature"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Ionicons.information_circle_outline),
              ),
            ],
          ),
          Obx(
            () => todoController.allTodos.isEmpty
                ? SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverFillRemaining(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Lottie.asset("assets/lotties/study.json"),
                          const SizedBox(height: 22),
                          Text(
                            "Get a clear view of the day ahead.",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            "All tasks due today will show up here tap the + to add a task",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    sliver: SliverFillRemaining(
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ListTile(
                            title:
                                Text("${todoController.allTodos[index].name}"),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 12);
                        },
                        itemCount: todoController.allTodos.length,
                      ),
                    ),
                  ),
          ),
        ],
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
