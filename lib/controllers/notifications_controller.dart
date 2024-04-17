import 'dart:math';

import "package:academia/exports/barrel.dart";
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  var isLoading = false.obs;
  var hasNotifications = false.obs;
  List notifications = [].obs;

  @override
  void onInit() async {
    super.onInit();
    if (Platform.isIOS || Platform.isAndroid) {}

    notifications = await magnet.fetchNotifications();
    hasNotifications.value = notifications.isNotEmpty;
    debugPrint("Notifications Done!");
  }

  // fetches the event calendar
  Future<void> fetchAcademicCalendar() async {
    var events = await magnet.fetchAcademicCalendar();
    if (events.isNotEmpty) {
      await appDB.put("academic_calendar", events);
    }
  }

  bool get hasCalendar {
    return appDB.containsKey("academic_calendar") ? true : false;
  }

  Future<List<Map<String, dynamic>>> get events async {
    if (appDB.containsKey("academic_calendar")) {
      return await appDB.get("academic_calendar");
    }
    return [];
  }

  int _generateRandomIntId({int min = 100000, int max = 999999}) {
    final random = Random();
    return min + random.nextInt(max - min);
  }

  Future<void> createInstantNotification(
    String title,
    String content, {
    NotificationLayout layout = NotificationLayout.BigPicture,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _generateRandomIntId(),
        channelKey: 'basic_channel',
        title: "${Emojis.building_school} $title",
        body: content,
        bigPicture: "asset://assets/images/bot_wave.png",
        notificationLayout: layout,
      ),
    );
  }

  /// Cancel all scheduled schedules
  ///
  /// Waring beware of cancelling all schedules it might result
  /// to deleting all schedules which might be unintended
  Future<void> cancelScheduledNotifications() async {
    await AwesomeNotifications().cancelAllSchedules();
  }
}
