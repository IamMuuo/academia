import 'package:academia/exports/barrel.dart';
import 'package:academia/storage/storage.dart';
import 'package:sqflite/sqflite.dart';

class SettingsModelHelper implements DatabaseOperations {
  static final SettingsModelHelper _instance = SettingsModelHelper._internal();

  factory SettingsModelHelper() {
    DatabaseHelper().registerModel('settings', '''
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    show_profile_picture INTEGER NOT NULL,
    notifications_enabled INTEGER NOT NULL,
    enable_transcript INTEGER NOT NULL,
    enable_audit INTEGER NOT NULL,
    show_fee_statistics INTEGER NOT NULL
    ''');

    return _instance;
  }

  SettingsModelHelper._internal();

  @override
  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'settings',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("[+] Settings written successfully");
    return id;
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final settings = await db.query('settings');
    return settings;
  }

  @override
  Future<int> delete(int id) async {
    final db = await DatabaseHelper().database;
    return await db.delete('settings', where: 'id =?', whereArgs: [id]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db.update(
      'settings',
      data,
      where: 'id =?',
      whereArgs: [data['id']],
    );
  }

  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM settings');
  }
}
