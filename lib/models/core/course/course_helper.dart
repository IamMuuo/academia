import 'package:academia/exports/barrel.dart';
import 'package:academia/storage/storage.dart';
import 'package:sqflite/sqlite_api.dart';

class CourseModelHelper implements DatabaseOperations {
  static final CourseModelHelper _instance = CourseModelHelper._internal();

  factory CourseModelHelper() {
    DatabaseHelper().registerModel('''
    CREATE TABLE IF NOT EXISTS courses(
      unit TEXT PRIMARY KEY,
      venue TEXT,
      section TEXT,
      time TEXT,
      day_of_the_week TEXT,
      period TEXT,
      room TEXT,
      lecturer TEXT
    );
    ''');

    return _instance;
  }

  CourseModelHelper._internal();
  @override

  /// Appends a course specified by [data] to the local DB
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

  /// Returns all the courses stored
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final courses = await db.query('courses');
    return courses;
  }

  @override

  /// Updates a stored course
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .update('courses', data, where: 'name =?', whereArgs: [data['name']]);
  }

  @override

  /// Unimplemented since the internal of course
  /// storage is not an integer id
  Future<int> delete(Map<String, dynamic> data) async {
    throw UnimplementedError();
  }

  /// Deletes a course given by [courseName] from the DB
  Future<int> deleteCourse(String courseName) async {
    final db = await DatabaseHelper().database;
    return await db
        .delete('courses', where: 'name =?', whereArgs: [courseName]);
  }

  @override

  /// Deletes all users
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM courses');
  }
}
