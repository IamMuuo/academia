import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import '../todo.dart';

class TodoController extends GetxController {
  final RxList<Todo> allTodos = <Todo>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllTodos().then((value) {
      debugPrint("[+] Todos Loaded");
    });
  }

  Future<bool> addTask(Todo t) async {
    int value = await TodoModelHelper().create(t.toJson());
    return value == 0 ? false : true;
  }

  Future<bool> updateTodo(Todo t) async {
    t.complete = !t.complete;
    int value = await TodoModelHelper().update(t.toJson());
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
    int value = await TodoModelHelper().delete(t.toJson());
    getAllTodos();
    return value == 0 ? false : true;
  }
}
