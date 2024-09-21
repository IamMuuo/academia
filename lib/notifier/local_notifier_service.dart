import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

import './local_notification_channel.dart';

enum NotificationType {
  defaultNotification,
  bigText,
  bigPicture,
}

/// A singleton class responsible for managing local notifications
/// in the Flutter application using Awesome Notifications.
///
/// This service supports multiple notification channels and ensures
/// that notifications are properly initialized and managed.
class LocalNotifierService {
  static final LocalNotifierService _instance =
      LocalNotifierService._internal();

  factory LocalNotifierService() {
    return _instance;
  }

  /// Private named constructor that prevents external instantiation.
  LocalNotifierService._internal();

  /// Initializes the notification service by setting up the required
  /// notification channels for the application.
  ///
  /// This method should be called during the app's startup to ensure
  /// that notifications can be created for the required channels.
  ///
  /// Example:
  /// ```dart
  /// await LocalNotifierService().initialize();
  /// ```
  Future<void> initialize() async {
    /// Initialize the flutter notifications plugin
    AwesomeNotifications().initialize(
      'resource://drawable/academia',
      [
        NotificationChannel(
          channelKey: LocalNotificationChannelType.general.channelKey,
          channelName: LocalNotificationChannelType.general.channelName,
          channelDescription:
              LocalNotificationChannelType.general.channelDescription,
          importance: NotificationImportance.High,
          enableLights: true,
          defaultColor: Colors.blueGrey,
          playSound: false,
          enableVibration: true,
          channelShowBadge: true,
        ),
        NotificationChannel(
          channelKey: LocalNotificationChannelType.reminders.channelKey,
          channelName: LocalNotificationChannelType.reminders.channelName,
          channelDescription:
              LocalNotificationChannelType.reminders.channelDescription,
          importance: NotificationImportance.High,
          enableLights: true,
          defaultColor: Colors.blueGrey,
          playSound: true,
          enableVibration: true,
          channelShowBadge: true,
        ),
      ],
    );
  }

  /// Requests permission from the user to display notifications.
  ///
  /// This method checks if notifications are allowed and if not,
  /// it prompts the user to enable notifications for the app.
  ///
  /// Example:
  /// ```dart
  /// await LocalNotifierService().requestPermission();
  /// ```
  Future<void> requestPermission() async {
    await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  /// Displays an instant notification with the provided content.
  ///
  /// Parameters:
  /// - `id`: A unique identifier for the notification.
  /// - `title`: The title of the notification.
  /// - `body`: The body content of the notification.
  /// - `payload`: Additional data that can be included in the notification.
  ///
  /// Example:
  /// ```dart
  /// await LocalNotifierService().showNotification(
  ///   id: 1,
  ///   title: 'Reminder',
  ///   body: 'You have a new task!',
  /// );
  /// ```

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required String channelKey, // New parameter for the channelKey
    NotificationType notificationType = NotificationType.defaultNotification,
    String? imageUrl, // For BigPicture notifications
    String? payload,
    NotificationCategory? category,
    Color? color,
  }) async {
    NotificationLayout layout = _getNotificationLayout(notificationType);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
        notificationLayout: layout,
        bigPicture:
            notificationType == NotificationType.bigPicture ? imageUrl : null,
        payload: {'payload_data': payload ?? 'No data'},
        category: category,
        color: color,
      ),
    );
  }

  /// Schedules a notification to be displayed at a specific time.
  ///
  /// Parameters:
  /// - `id`: A unique identifier for the notification.
  /// - `title`: The title of the notification.
  /// - `body`: The body content of the notification.
  /// - `scheduledTime`: The time at which the notification should be displayed.
  ///
  /// Example:
  /// ```dart
  /// await LocalNotifierService().scheduleNotification(
  ///   id: 2,
  ///   title: 'Scheduled Task',
  ///   body: 'This is a scheduled notification.',
  ///   scheduledTime: DateTime.now().add(Duration(hours: 2)),
  /// );
  /// ```
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
    required String channelKey, // New parameter for the channelKey
    NotificationType notificationType = NotificationType.defaultNotification,
    NotificationCategory? category,
    Color? color,
    String? imageUrl, // For BigPicture notifications
  }) async {
    NotificationLayout layout = _getNotificationLayout(notificationType);

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: channelKey,
        title: title,
        body: body,
        notificationLayout: layout,
        bigPicture:
            notificationType == NotificationType.bigPicture ? imageUrl : null,
        category: category,
        color: color,
      ),
      schedule: NotificationCalendar.fromDate(date: scheduledTime),
    );
  }

  /// Cancels a specific notification by its unique ID.
  ///
  /// Parameters:
  /// - `id`: The unique identifier of the notification to cancel.
  ///
  /// Example:
  /// ```dart
  /// await LocalNotifierService().cancelNotification(1);
  /// ```
  Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
  }

  /// Cancels all notifications created by the app.
  ///
  /// Example:
  /// ```dart
  /// await LocalNotifierService().cancelAllNotifications();
  /// ```
  Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
  }

  NotificationLayout _getNotificationLayout(NotificationType notificationType) {
    switch (notificationType) {
      case NotificationType.bigText:
        return NotificationLayout.BigText;
      case NotificationType.bigPicture:
        return NotificationLayout.BigPicture;
      default:
        return NotificationLayout.Default;
    }
  }
}
