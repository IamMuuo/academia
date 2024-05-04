import 'package:academia/storage/storage.dart';
import 'package:sqflite/sqflite.dart';

class TodoModelHelper {
  static final TodoModelHelper _instance = TodoModelHelper._internal();

  factory TodoModelHelper() {
    DatabaseHelper().registerModel('todos', '''
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      date TEXT NOT NULL,
      remindDate TEXT NOT NULL,
      color TEXT NOT NULL,
      pictureAttachment TEXT,
      note TEXT,
    ''');

    return _instance;
  }

  TodoModelHelper._internal();

  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'todos',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final todos = await db.query('todos');
    return todos;
  }

  Future<int> delete(int id) async {
    final db = await DatabaseHelper().database;
    return await db.delete('todos', where: 'id =?', whereArgs: [id]);
  }

  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .update('todos', data, where: 'id =?', whereArgs: [data['id']]);
  }

  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM todos');
  }
}
