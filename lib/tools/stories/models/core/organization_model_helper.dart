import 'package:academia/storage/storage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

class OrganizationModelHelper implements DatabaseOperations {
  static final OrganizationModelHelper _instance =
      OrganizationModelHelper._internal();

  factory OrganizationModelHelper() {
    return _instance;
  }

  OrganizationModelHelper._internal();

  @override
  Future<int> create(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    final id = await db.insert(
      'organizations',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint("[+] Organization written successfully");
    return id;
  }

  @override
  Future<List<Map<String, dynamic>>> queryAll() async {
    final db = await DatabaseHelper().database;
    final organizations = await db.query('organizations');
    return organizations;
  }

  @override
  Future<int> delete(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .delete('organizations', where: 'id =?', whereArgs: [data["id"]]);
  }

  @override
  Future<int> update(Map<String, dynamic> data) async {
    final db = await DatabaseHelper().database;
    return await db
        .update('organizations', data, where: 'id =?', whereArgs: [data['id']]);
  }

  @override
  Future<void> truncate() async {
    final db = await DatabaseHelper().database;
    await db.execute('DELETE FROM organizations');
  }
}
