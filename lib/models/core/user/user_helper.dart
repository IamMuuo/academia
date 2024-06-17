import 'package:academia/exports/barrel.dart';
import 'package:academia/storage/storage.dart';
import 'package:sqflite/sqflite.dart';

class UserModelHelper implements DatabaseOperations {
  static final UserModelHelper _instance = UserModelHelper._internal();

  factory UserModelHelper() {
    DatabaseHelper().registerModel("""
    CREATE TABLE IF NOT EXISTS users (
      id TEXT PRIMARY KEY,
      username TEXT NOT NULL UNIQUE,
      first_name TEXT NOT NULL,
      last_name TEXT NOT NULL,
      admission_number TEXT UNIQUE,
      national_id TEXT UNIQUE,
      gender TEXT,
      address TEXT,
      email TEXT UNIQUE,
      date_of_birth TEXT,
      campus TEXT,
      profile_url TEXT,
      password TEXT,
      active INTEGER,
      vibe_points INTEGER,
      point_transactions TEXT,
      date_created TEXT,
      date_updated TEXT
    );
    """);

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
    data["active"] == true ? 1 : 0;
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
    users.map((e) {
      e["active"] == 1 ? true : false;
    });
    return users;
  }

  @override
  Future<int> delete(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db.delete('users', where: 'id =?', whereArgs: [data["id"]]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    data["active"] == true ? 1 : 0;
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
