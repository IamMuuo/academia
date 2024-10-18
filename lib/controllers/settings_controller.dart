import 'dart:async';

import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:academia/models/models.dart';
import 'package:academia/storage/storage.dart';
import 'package:local_auth/local_auth.dart';

class SettingsController extends GetxController with StateMixin {
  Rx<Settings> settings = Settings.empty().obs;

  final LocalAuthentication localAuthentication = LocalAuthentication();

  @override
  void onInit() async {
    super.onInit();
    ever(settings, (value) {
      saveSettings(value);
    });

    change(null, status: RxStatus.loading());
    await SettingsHelper().init();

    settings.value = SettingsHelper().getSettings();
    // print(settings.value.toJson());
    debugPrint("[+] Settings Loaded!");

    change(null, status: RxStatus.success());
  }

  Future<bool> performLocalAuthentication(String reason) async {
    bool authenticated = false;

    if (Platform.isIOS || Platform.isAndroid) {
      try {
        authenticated = await localAuthentication.authenticate(
          localizedReason: reason,
          options: const AuthenticationOptions(
            stickyAuth: true,
            sensitiveTransaction: true,
          ),
        );
      } on PlatformException catch (e) {
        authenticated = false;
        debugPrint(e.toString());
      } catch (e) {
        debugPrint(e.toString());
      }

      return authenticated;
    }
    return true;
  }

  Future<bool> deviceSupportsLocalAuth() async {
    return localAuthentication.isDeviceSupported();
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
