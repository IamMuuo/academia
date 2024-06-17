import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:academia/models/models.dart';

class SettingsController extends GetxController {
  Rx<Settings> settings = Settings.empty().obs;

  @override
  void onInit() async {
    super.onInit();
    await SettingsHelper().init();

    settings.value = SettingsHelper().getSettings();
    debugPrint("[+] Settings Loaded!");
  }
}
