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
  var appDB = await Hive.openBox("appDB");
  User user = appDB.get("user");

  runApp(GetMaterialApp(
    //TODO: update
    home: user.admno != null ? const IntroPage() : const HomePage(),
    theme: lightModeTheme,
  ));
}
