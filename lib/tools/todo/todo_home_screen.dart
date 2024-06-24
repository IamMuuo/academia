import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/todo/todo_view_page.dart';
import 'package:academia/tools/todo/widgets/filled_todo_homescreen.dart';
import 'package:get/get.dart';

class TodoHomeScreen extends StatelessWidget {
  const TodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoController = Get.find<TodoController>();
    return Scaffold(
      body: Obx(
        () => todoController.allTodos.isEmpty
            ? const EmptyTodoHomeScreen()
            : const FilledTodoHomeScreen(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
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
