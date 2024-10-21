import 'package:academia/exports/barrel.dart';
import 'package:academia/storage/storage.dart';
import 'package:sqflite/sqlite_api.dart';

class ExamModelHelper implements DatabaseOperations {
  static final ExamModelHelper _instance = ExamModelHelper._internal();

  factory ExamModelHelper() {
    return _instance;
  }

  ExamModelHelper._internal();

  @override
  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'exams',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("[+] Exam written successfully");
    return id;
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final exams = await db.query('exams');
    return exams;
  }

  @override
  Future<int> delete(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db.delete('exams',
        where: 'course_code = ?', whereArgs: [data['course_code']]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db.update(
      'exams',
      data,
      where: 'course_code = ?',
      whereArgs: [data['course_code']],
    );
  }

  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM exams');
  }
}
