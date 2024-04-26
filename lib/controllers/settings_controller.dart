import 'package:academia/exports/barrel.dart';
import 'package:academia/services/services.dart';
import 'package:get/get.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

class SettingsController extends GetxController {
  Rx<bool> showGPA = true.obs;
  Rx<bool> showProfilePic = true.obs;
  Rx<bool> showExamTimeTable = false.obs;
  Rx<bool> showTranscript = false.obs;
  Rx<bool> showAudit = false.obs;
  Rx<bool> showFees = true.obs;
  Rx<bool> birthdayNotify = true.obs;
  Rx<bool> hasUpdates = false.obs;
  Rx<String> patch = "0.0.0".obs;
  late Map<dynamic, dynamic> settings;
  late ShorebirdCodePush? shorebirdCodePush;

  @override
  void onInit() async {
    settings = await StorageService().appDB.get("settings") ?? {};
    showGPA.value = settings["show_gpa"] ?? true;
    showProfilePic.value = settings["show_profile_pic"] ?? true;
    showExamTimeTable.value = settings["show_exam_timetable"] ?? true;
    showAudit.value = settings["show_audit"] ?? true;
    showTranscript.value = settings["show_transcript"] ?? true;
    showFees.value = settings["show_fees"] ?? false;
    birthdayNotify.value = settings["birthday_notify"] ?? true;

    debugPrint("Settings loaded!");
    super.onInit();

    if (Platform.isAndroid) {
      shorebirdCodePush = ShorebirdCodePush();
      shorebirdCodePush?.currentPatchNumber().then(
        (value) {
          patch.value = value?.toString() ?? "monkey";
          debugPrint("Current patch number is: $value");
        },
      );

      checkForUpdates();
    }
  }

  Future<void> saveSettings() async {
    settings["show_profile_pic"] = showProfilePic.value;
    settings["show_gpa"] = showGPA.value;
    settings["show_exam_timetable"] = showExamTimeTable.value;
    settings["show_transcript"] = showTranscript.value;
    settings["show_audit"] = showAudit.value;
    settings["show_fees"] = showFees.value;
    settings["birthday_notify"] = birthdayNotify.value;
    await StorageService().appDB.put("settings", settings);
  }

  Future<void> checkForUpdates() async {
    // Check whether a patch is available to install.
    hasUpdates.value =
        await shorebirdCodePush?.isNewPatchAvailableForDownload() ?? false;

    if (hasUpdates.value) {
      // Download the new patch if it's available.
      await shorebirdCodePush?.downloadUpdateIfAvailable();
    }
    hasUpdates.value = false;
  }
}
