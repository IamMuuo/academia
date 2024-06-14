import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  RxList<Todo> todos = <Todo>[].obs;

  @override

  /// Opens the database
  /// Initializes the [todos] if they exist in the database
  void onInit() {
    // Read all todos
    TodoModelHelper().queryAll().then(
        (value) => todos.value = value.map((e) => Todo.fromJson(e)).toList());
    super.onInit();
    debugPrint("[+] Todo initialized successfully");
  }

  /// Adds a todo specified by [newTodo] to the local db
  Future<void> createTodo(Todo newTodo) async {
    await TodoModelHelper().create(newTodo.toJson());
    TodoModelHelper().queryAll().then(
        (value) => todos.value = value.map((e) => Todo.fromJson(e)).toList());
  }

  /// Deletes both from db and [todos] a todo specified by [id]
  Future<void> deleteTodo(int id) async {
    throw UnimplementedError();
    // todos.removeWhere((element) => element.id == id);
    // await TodoModelHelper().delete();
    // update();
  }

  /// Deletes both from db and [todos] a todo specified by [id]
  Future<void> updateTodo(Todo update) async {
    todos.removeWhere((element) => element.id == update.id);
    await TodoModelHelper().update(update.toJson());
    TodoModelHelper().queryAll().then(
        (value) => todos.value = value.map((e) => Todo.fromJson(e)).toList());
  }

  List<Todo> filterTodosByDate(String filterOption) {
    DateTime now = DateTime.now();
    DateTime tomorrow = now.add(const Duration(days: 1));

    switch (filterOption.toLowerCase()) {
      case "today":
        return todos.where((todo) => todo.date.isAtSameMomentAs(now)).toList();
      case "tomorrow":
        return todos
            .where((todo) => todo.date.isAtSameMomentAs(tomorrow))
            .toList();
      case "week":
        return todos
            .where((todo) =>
                todo.date.isAfter(now.subtract(const Duration(days: 7))))
            .toList();
      case "month":
        return todos
            .where((todo) =>
                todo.date.isAfter(now.subtract(const Duration(days: 30))))
            .toList();
      default:
        return todos; // Return all todos if no valid filter option is provided
    }
  }
}
