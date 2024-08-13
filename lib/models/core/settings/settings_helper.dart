import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'settings.dart';

class SettingsHelper {
  static final SettingsHelper _instance = SettingsHelper._internal();
  late SharedPreferences _prefs;

  factory SettingsHelper() {
    // SharedPreferences.getInstance().then((value) {
    //   _instance._prefs = value;
    // });
    return _instance;
  }

  SettingsHelper._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Settings getSettings() {
    String? settingsJsonString = _prefs.getString('settings');
    if (settingsJsonString != null) {
      Map<String, dynamic> json = jsonDecode(settingsJsonString);
      return Settings.fromJson(json);
    } else {
      // Return default settings if not found
      return Settings.empty();
    }
  }

  Future<bool> saveSettings(Settings settings) async {
    String json = jsonEncode(settings.toJson());
    return await _prefs.setString('settings', json);
  }
}
