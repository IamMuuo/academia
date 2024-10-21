import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import 'package:academia/exports/barrel.dart';
import 'package:academia/storage/storage.dart';

class CourseTopicModelHelper implements DatabaseOperations {
  static final CourseTopicModelHelper _instance =
      CourseTopicModelHelper._internal();

  factory CourseTopicModelHelper() {
    return _instance;
  }

  CourseTopicModelHelper._internal();

  @override
  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'course_topics',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("[+] Course Topic written successfully");
    return id;
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final courseTopics = await db.query('course_topics');
    return courseTopics;
  }

  @override
  Future<int> delete(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .delete('course_topics', where: 'id = ?', whereArgs: [data["id"]]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db.update('course_topics', data,
        where: 'id = ?', whereArgs: [data['id']]);
  }

  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM course_topics');
  }
}
