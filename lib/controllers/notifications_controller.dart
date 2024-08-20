import 'dart:math';

import "package:academia/exports/barrel.dart";
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  int _generateRandomIntId({int min = 100000, int max = 999999}) {
    final random = Random();
    return min + random.nextInt(max - min);
  }

  Future<void> createInstantNotification(
    String title,
    String content, {
    NotificationLayout? layout,
    String? bigPicture,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: _generateRandomIntId(),
        channelKey: 'social',
        title: title,
        body: content,
        bigPicture: bigPicture,
        notificationLayout: layout ?? NotificationLayout.Default,
      ),
    );
  }

  Future<bool> scheduleNotification(
    DateTime date,
    String title,
    String body, {
    String? channelKey,
    NotificationLayout? notificationLayout,
    String? bigPicture,
    Color? color,
    Color? backgroundColor,
    NotificationCategory? category,
    bool repeats = false,
  }) async {
    return await AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
        day: date.day,
        month: date.month,
        year: date.year,
        preciseAlarm: true,
        allowWhileIdle: true,
        repeats: repeats,
      ),
      content: NotificationContent(
        id: _generateRandomIntId(),
        body: body,
        title: title,
        wakeUpScreen: channelKey == null ? false : true,
        color: color,
        backgroundColor: backgroundColor,
        channelKey: channelKey ?? "social",
        notificationLayout: notificationLayout ?? NotificationLayout.Default,
        bigPicture: bigPicture,
        category: category ?? NotificationCategory.Message,
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
