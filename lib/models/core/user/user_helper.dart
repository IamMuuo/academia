import 'package:academia/exports/barrel.dart';
import 'package:academia/storage/storage.dart';
import 'package:sqflite/sqflite.dart';

class UserModelHelper implements DatabaseOperations {
  static final UserModelHelper _instance = UserModelHelper._internal();

  factory UserModelHelper() {
    return _instance;
  }

  UserModelHelper._internal();

  @override

  /// Create.
  /// Calling this appends a user model onto the users table
  /// incase such a user exists it replaces the user data with the new
  /// data
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
  Future<int> delete(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db.delete('users', where: 'id =?', whereArgs: [data["id"]]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .update('users', data, where: 'id =?', whereArgs: [data['id']]);
  }

  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM users');
  }
}
