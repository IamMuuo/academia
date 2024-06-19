import 'package:academia/exports/barrel.dart';
import 'package:academia/storage/storage.dart';
import 'package:sqflite/sqlite_api.dart';

class CourseModelHelper implements DatabaseOperations {
  static final CourseModelHelper _instance = CourseModelHelper._internal();

  factory CourseModelHelper() {
    // Ensure the table is created when the factory constructor is called
    DatabaseHelper().registerModel("""
      CREATE TABLE IF NOT EXISTS courses (
        unit TEXT PRIMARY KEY,
        section TEXT NOT NULL,
        day_of_the_week TEXT NOT NULL,
        period TEXT NOT NULL,
        campus TEXT NOT NULL,
        room TEXT NOT NULL,
        lecturer TEXT NOT NULL
      );
    """);

    return _instance;
  }

  CourseModelHelper._internal();

  @override
  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'courses',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("[+] Course written successfully");
    return id;
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final courses = await db.query('courses');
    return courses;
  }

  @override
  Future<int> delete(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db.delete('courses', where: 'id =?', whereArgs: [data["id"]]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .update('courses', data, where: 'id =?', whereArgs: [data['id']]);
  }

  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM courses');
  }
}
