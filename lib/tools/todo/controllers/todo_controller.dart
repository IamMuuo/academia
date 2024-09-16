import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  final RxList<Todo> allTodos = <Todo>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllTodos().then((value) {
      debugPrint("[+] Todos Loaded");
    });
  }

  List<Todo> filterTodosByDate(String filterOption) {
    final todos = allTodos;
    final today = DateTime.now();
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    switch (filterOption.toLowerCase().trim()) {
      case "today":
        return todos
            .where((element) =>
                element.due.day == today.day &&
                element.due.month == today.month &&
                element.due.year == today.year)
            .toList(growable: false);

      case "tommorrow":
        return todos
            .where((element) =>
                element.due.day == tomorrow.day &&
                element.due.month == tomorrow.month &&
                element.due.year == tomorrow.year)
            .toList(growable: false);

      case "week":
        return todos
            .where((element) =>
                element.due.isAfter(today) &&
                element.due.difference(today).inDays < 7)
            .toList(growable: false);

      case "month":
        return todos
            .where((element) =>
                element.due.day < 31 &&
                element.due.month == today.month &&
                element.due.year == today.year)
            .toList(growable: false);

      default:
        return todos;
    }
  }

  Future<bool> addTask(Todo t) async {
    int value = await TodoModelHelper().create(t.toJson());
    allTodos.add(t);
    return value == 0 ? false : true;
  }

  Future<bool> updateTodo(Todo t) async {
    allTodos.removeWhere((todo) => todo.id == t.id);
    int value = await TodoModelHelper().update(t.toJson());
    allTodos.add(t);
    return value == 0 ? false : true;
  }

  Future<List<Todo>> getAllTodos() async {
    TodoModelHelper().queryAll().then((value) {
      allTodos.clear();
      for (final val in value) {
        allTodos.add(Todo.fromJson(val));
      }
    });
    return allTodos;
  }

  Future<bool> deleteTodo(Todo t) async {
    allTodos.removeWhere((value) => t.id == value.id);
    int value = await TodoModelHelper().delete(t.toJson());
    return value == 0 ? false : true;
  }
}
