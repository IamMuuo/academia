import 'package:academia/storage/storage.dart';
import 'package:academia/exports/barrel.dart';
import 'package:sqflite/sqflite.dart';

class AnkiCardModelHelper implements DatabaseOperations {
  static final AnkiCardModelHelper _instance = AnkiCardModelHelper._internal();

  factory AnkiCardModelHelper() {
    return _instance;
  }

  AnkiCardModelHelper._internal();

  @override
  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'ankiCards',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("[+] Anki Card Created Succcessfuly");
    return id;
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final ankiCards = await db.query('ankiCards');
    return ankiCards;
  }

  @override
  Future<int> delete(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .delete('ankiCards', where: 'id = ?', whereArgs: [data["id"]]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .update('ankiCards', data, where: 'id = ?', whereArgs: [data['id']]);
  }

  Future<List<Map<String, dynamic>>> queryAnkiCardsByTopic(int topicId) async {
    final db = await DatabaseHelper().database;
    return await db.query(
      'ankiCards',
      where: 'topic_id = ?',
      whereArgs: [topicId],
    );
  }

  // make sure to call in the logout function
  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM ankiCards');
  }
}
