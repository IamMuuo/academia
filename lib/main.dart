import 'package:academia/constants/common.dart';
import 'package:academia/models/courses.dart';
import 'package:academia/models/schedule.dart';
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
  Hive.registerAdapter(ScheduleAdapter());
  Hive.registerAdapter(CoursesAdapter());
  appDB = await Hive.openBox(dbName);

  bool isLoggedIn = false;

  if (appDB.containsKey("user")) {
    user = User.fromJson(appDB.get("user"));
    isLoggedIn = true;
  }
  runApp(
    GetMaterialApp(
      home: isLoggedIn ? const HomePage() : const IntroPage(),
      theme: lightModeTheme,
    ),
  );
}
