import 'package:academia/storage/storage.dart';
import 'package:sqflite/sqflite.dart';

class RewardModelHelper implements DatabaseOperations {
  static final RewardModelHelper _instance = RewardModelHelper._internal();

  factory RewardModelHelper() {
    DatabaseHelper().registerModel('''
      CREATE TABLE IF NOT EXISTS rewards (
        id TEXT PRIMARY KEY,
        student_id TEXT NOT NULL,
        points INTEGER NOT NULL,
        reason TEXT NOT NULL,
        awarded_at TEXT NOT NULL
      )
    ''');

    return _instance;
  }

  RewardModelHelper._internal();

  @override
  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'rewards',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final rewards = await db.query('rewards');
    return rewards;
  }

  @override
  Future<int> delete(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db.delete('rewards', where: 'id = ?', whereArgs: [data['id']]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .update('rewards', data, where: 'id = ?', whereArgs: [data['id']]);
  }

  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM rewards');
  }
}
