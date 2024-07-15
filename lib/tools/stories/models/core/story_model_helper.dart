import 'package:academia/storage/storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class StoryModelHelper implements DatabaseOperations {
  static final StoryModelHelper _instance = StoryModelHelper._internal();

  factory StoryModelHelper() {
    return _instance;
  }

  StoryModelHelper._internal();

  @override
  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'stories',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("[+] Story written successfully");
    return id;
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final stories = await db.query('stories');
    return stories;
  }

  @override
  Future<int> delete(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db.delete('stories', where: 'id =?', whereArgs: [data["id"]]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .update('stories', data, where: 'id =?', whereArgs: [data['id']]);
  }

  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM stories');
  }
}
