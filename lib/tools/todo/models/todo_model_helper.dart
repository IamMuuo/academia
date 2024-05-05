import 'package:academia/storage/storage.dart';
import 'todo_model.dart';
import 'package:sqflite/sqflite.dart';

class TodoModelHelper {
  static final TodoModelHelper _instance = TodoModelHelper._internal();

  factory TodoModelHelper() {
    return _instance;
  }

  TodoModelHelper._internal();

  // Register the table schema
  void registerModel(Database db) {
    db.execute('''
      CREATE TABLE IF NOT EXISTS todos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        date TEXT NOT NULL,
        notificationTime TEXT NOT NULL,
        notificationFrequency TEXT NOT NULL,
        color TEXT NOT NULL,
        description TEXT,
        complete INTEGER NOT NULL,
        dateAdded TEXT NOT NULL
      )
    ''');
  }

  // Insert a new Todo
  Future<int> insert(Todo todo) async {
    final db = await DatabaseHelper().database;
    return await db.insert(
      'todos',
      todo.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all Todos
  Future<List<Todo>> getAllTodos() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('todos');

    return List.generate(maps.length, (i) {
      return Todo.fromJson(maps[i]);
    });
  }

  // Update a Todo
  Future<int> update(Todo todo) async {
    final db = await DatabaseHelper().database;
    return await db.update(
      'todos',
      todo.toJson(),
      where: 'id =?',
      whereArgs: [todo.id],
    );
  }

  // Delete a Todo
  Future<int> delete(int id) async {
    final db = await DatabaseHelper().database;
    return await db.delete(
      'todos',
      where: 'id =?',
      whereArgs: [id],
    );
  }
}
