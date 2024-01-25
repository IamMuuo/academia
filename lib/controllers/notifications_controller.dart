import 'package:academia/constants/common.dart';
import 'package:academia/notifications/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  var isLoading = false.obs;

  NotificationsController() {
    NotificationService().scheduleNotification(
        0,
        "Happy Birthday",
        "We wish you a happy birthday and prosperous new year",
        DateTime.now().add(const Duration(seconds: 10)));

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

  void scheduleNotificationForWeeklyClass(
      String className, TimeOfDay classTime, int dayOfWeek) {
    DateTime now = DateTime.now();
    DateTime scheduledDate = DateTime(
      now.year,
      now.month,
      now.day + (dayOfWeek - now.weekday + 7) % 7,
      classTime.hour,
      classTime.minute,
    );

    // If the scheduled date is in the past, add a week to it
    if (now.isAfter(scheduledDate)) {
      scheduledDate = scheduledDate.add(const Duration(days: 7));
    }

    // Schedule the notification
    NotificationService().scheduleNotification(
      notifications["course"]!,
      "Class reminder⏱️⏱️",
      "$className is about to begin",
      scheduledDate,
    );
  }
}
