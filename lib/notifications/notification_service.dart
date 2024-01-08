//////////////////////////////////////////////////////////////////////////////////
// File Notification Service
// Author: Erick Muuo
// Email: hearteric57@gmail.com
// Description: Read dont touch !!!!
//////////////////////////////////////////////////////////////////////////////////

// WARNING: NO SUPPORT FOR IOS, LINUX, MAC, WEB or WINDOWS
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

// Hands off dont touch this Code
// Signed Erick Muuo
class NotificationService {
  // Create a  singleton instance
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidNotificationDetails _androidNotificationDetails =
      const AndroidNotificationDetails("channel ID", "channel name",
          playSound: true,
          priority: Priority.high,
          importance: Importance.high);

  late NotificationDetails platformChannelSpecifics;

// notifications initialize called only once
  Future<void> initNotifications() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings("app_icon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    platformChannelSpecifics =
        NotificationDetails(android: _androidNotificationDetails);

    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Show a notification instantly
  Future<void> showNotification({
    String title = "Academia",
    String body = "Hi from Academia",
    int id = 0,
    String payload = "Greeting",
  }) async {
    await flutterLocalNotificationsPlugin
        .show(id, title, body, platformChannelSpecifics, payload: payload);
  }

  // Schedule Notifications
  Future<void> scheduleNotification(
    int id,
    String title,
    String body,
    Duration duration,
  ) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.now(tz.local).add(duration),
      platformChannelSpecifics,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  // Cancels a notification specified by ID
  Future<void> cancelNotifications(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  // Cancels all previously scheduled notifications
  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}

Future selectNotification(String payload) async {
  Get.snackbar("Notification", payload);
}
