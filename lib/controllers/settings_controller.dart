import 'package:academia/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:academia/models/models.dart';
import 'package:academia/storage/storage.dart';

class SettingsController extends GetxController {
  Rx<Settings> settings = Settings.empty().obs;

  @override
  void onInit() async {
    super.onInit();
    await SettingsHelper().init();

    settings.value = SettingsHelper().getSettings();
    debugPrint("[+] Settings Loaded!");

    ever(settings, (value) {
      saveSettings(value);
    });
  }

  /// Saves the current settings
  void saveSettings(Settings settings) async {
    this.settings.value = settings;
    await SettingsHelper().saveSettings(settings);
  }

  Future<void> _truncateDatabase() async {
    await DatabaseHelper().truncateDataBase();
  }

  Future<void> logout() async {
    await _truncateDatabase();
    final userController = Get.find<UserController>();
    userController.isLoggedIn.value = false;
  }
}
