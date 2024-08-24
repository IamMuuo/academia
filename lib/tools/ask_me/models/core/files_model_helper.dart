import 'package:academia/storage/storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class FilesModelHelper implements DatabaseOperations {
  static final FilesModelHelper _instance =
      FilesModelHelper._internal();

  factory FilesModelHelper() {
    return _instance;
  }

  FilesModelHelper._internal();

  @override
  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'askme_files',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("[+] Files written successfully");
    return id;
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final files = await db.query('askme_files');
    return files;
  }

  @override
  Future<int> delete(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .delete('askme_files', where: 'id =?', whereArgs: [data["id"]]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .update('askme_files', data, where: 'id =?', whereArgs: [data['id']]);
  }

  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM askme_files');
  }
}
