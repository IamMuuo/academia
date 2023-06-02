import 'package:academia/constants/common.dart';
import 'package:academia/models/user.dart';
import 'package:academia/pages/home_page.dart';
import 'package:academia/pages/intro_page.dart';
import 'package:academia/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';

void main() async {
  // Init flutter
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Box appDB = await Hive.openBox(dbName);


  runApp(
    GetMaterialApp(
      home: appDB.containsKey("user") ? const HomePage() : const IntroPage(),
      theme: lightModeTheme,
    ),
  );
}
