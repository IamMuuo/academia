import 'package:academia/storage/storage.dart';
import 'package:academia/exports/barrel.dart';
import 'package:sqflite/sqflite.dart';

class TodoModelHelper implements DatabaseOperations {
  static final TodoModelHelper _instance = TodoModelHelper._internal();

  factory TodoModelHelper() {
    return _instance;
  }

  TodoModelHelper._internal();

  @override
  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'todos',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("[+] Todo written successfully");
    return id;
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final todos = await db.query('todos');
    return todos;
  }

  @override
  Future<int> delete(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [data["id"]]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .update('todos', data, where: 'id = ?', whereArgs: [data['id']]);
  }

  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM todos');
  }
}
