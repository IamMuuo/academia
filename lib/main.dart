import 'package:academia/app.dart';
import 'package:academia/database/database.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();
  runApp(const Academia());
}
