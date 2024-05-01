import 'package:academia/exports/barrel.dart';
import 'package:academia/storage/storage.dart';
import 'package:sqflite/sqflite.dart';

class UserModelHelper implements DatabaseOperations {
  static final UserModelHelper _instance = UserModelHelper._internal();

  factory UserModelHelper() {
    DatabaseHelper().registerModel('users', '''
    regno TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    idno TEXT NOT NULL,
    gender TEXT NOT NULL,
    address TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    dateofbirth TEXT NOT NULL,
    campus TEXT NOT NULL,
    profile TEXT,
    password TEXT NOT NULL
    ''');

    return _instance;
  }

  UserModelHelper._internal();

  @override

  /// Create.
  /// Calling this appends a user model onto the
  // user's table
  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'users',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("[+] User written successfully");
    return id;
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final users = await db.query('users');
    return users;
  }

  @override
  Future<int> delete(int id) async {
    final db = await DatabaseHelper().database;
    return await db.delete('users', where: 'regno =?', whereArgs: [id]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .update('users', data, where: 'regno =?', whereArgs: [data['regno']]);
  }

  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM users');
  }
}
