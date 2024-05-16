import 'package:academia/exports/barrel.dart';
import 'package:academia/models/settings/settings.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  Rxn<SettingsModel> settings = Rxn();

  @override
  void onInit() {
    super.onInit();
    SettingsModelHelper().queryAll().then((value) {
      if (value.isEmpty) {
        SettingsModelHelper().create(SettingsModel().toJson());
      }
      settings.value = SettingsModel.fromMap(
          value.isEmpty ? SettingsModel().toJson() : value[0]);
    });

    debugPrint("[+] Settings loaded!");
  }

  Future<bool> saveSettings() async {
    await SettingsModelHelper().update(settings.value!.toMap());
    return true;
  }
}
