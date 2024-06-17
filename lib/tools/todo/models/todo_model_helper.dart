import 'package:academia/storage/storage.dart';
import 'package:academia/exports/barrel.dart';
import 'package:sqflite/sqflite.dart';

class TodoModelHelper implements DatabaseOperations {
  static final TodoModelHelper _instance = TodoModelHelper._internal();

  factory TodoModelHelper() {
    DatabaseHelper().registerModel('''
    CREATE TABLE IF NOT EXISTS todos (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      date TEXT NOT NULL,
      notification_time TEXT NOT NULL,
      notification_frequency TEXT NOT NULL,
      color TEXT NOT NULL,
      description TEXT,
      complete INTEGER NOT NULL,
      date_added TEXT NOT NULL,
      date_completed TEXT
    );
    ''');

    return _instance;
  }

  TodoModelHelper._internal();

  @override

  /// Inserts a new todo on the local database specified by [data]
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

  /// Queries for all todos stored in the local database
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final users = await db.query('todos');
    return users;
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .update('todos', data, where: 'id =?', whereArgs: [data['id']]);
  }

  @override

  /// Deletes a todo specified with id [id]
  Future<int> delete(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db.delete('todos', where: 'id =?', whereArgs: [data["id"]]);
  }

  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;

    await db.execute('DROP TABLE todos');
  }
}
