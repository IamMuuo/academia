import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../todo.dart';

class TodoController extends GetxController {
  final RxList<Todo> allTodos = <Todo>[].obs;
  @override
  void onInit() {
    super.onInit();
    TodoModelHelper().queryAll().then((value) {
      for (final val in value) {
        allTodos.add(Todo.fromJson(val));
        debugPrint("[+]Todo loaded");
      }
    });
  }

  Future<bool> addTask(Todo t) async {
    int value = await TodoModelHelper().create(t.toJson());
    return value == 0 ? false : true;
  }
}
