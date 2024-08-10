import 'package:academia/storage/storage.dart';
import 'package:academia/exports/barrel.dart';
import 'package:sqflite/sqflite.dart';

class TopicModelHelper implements DatabaseOperations {
  static final TopicModelHelper _instance = TopicModelHelper._internal();

  factory TopicModelHelper() {
    return _instance;
  }

  TopicModelHelper._internal();

  @override
  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'ankiTopics',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("[+] Anki Topic Created Succcessfuly");
    return id;
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final todos = await db.query('ankiTopics');
    return todos;
  }

  @override
  Future<int> delete(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .delete('ankiTopics', where: 'id = ?', whereArgs: [data["id"]]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .update('ankiTopics', data, where: 'id = ?', whereArgs: [data['id']]);
  }

  // make sure to call in the logout function
  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM ankiTopics');
  }
}
