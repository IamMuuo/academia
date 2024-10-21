import 'package:academia/storage/storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class ScoresModelHelper implements DatabaseOperations {
  static final ScoresModelHelper _instance =
      ScoresModelHelper._internal();

  factory ScoresModelHelper() {
    return _instance;
  }

  ScoresModelHelper._internal();

  @override
  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'askme_scores',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("[+] Scores written successfully");
    return id;
  }

  Future<List<Map<String, dynamic>>> queryScoresByFileId(int fileId) async {
    final db = await DatabaseHelper().database;
    return await db.query('askme_scores', where: 'filesId = ?', whereArgs: [fileId]);
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final scores = await db.query('askme_scores');
    return scores;
  }

  @override
  Future<int> delete(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .delete('askme_scores', where: 'id =?', whereArgs: [data["id"]]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .update('askme_scores', data, where: 'id =?', whereArgs: [data['id']]);
  }

  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM askme_scores');
  }
}
