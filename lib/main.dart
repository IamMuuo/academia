import 'package:academia/constants/common.dart';
import 'package:academia/controllers/settings_controller.dart';
import 'package:academia/models/courses.dart';
import 'package:academia/models/schedule.dart';
import 'package:academia/models/user.dart';
import 'package:academia/pages/home_page.dart';
import 'package:academia/pages/intro_page.dart';
import 'package:academia/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:magnet/magnet.dart';

void main() async {
  // Init flutter
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ScheduleAdapter());
  Hive.registerAdapter(CoursesAdapter());
  appDB = await Hive.openBox(dbName);

  bool isLoggedIn = false;
  if (appDB.containsKey("user")) {
    user = await appDB.get("user");
    isLoggedIn = true;
    magnet = Magnet(user.admno!, user.password!);
  }

  // Init settings controller
  Get.put(SettingsController());

  runApp(
    GetMaterialApp(
      home: isLoggedIn ? const HomePage() : const IntroPage(),
      theme: lightModeTheme,
    ),
  );
}
