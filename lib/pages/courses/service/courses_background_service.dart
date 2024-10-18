import 'package:academia/exports/barrel.dart';
import 'package:academia/models/core/course/course.dart';
import 'package:academia/notifier/local_notification_channel.dart';
import 'package:academia/notifier/local_notification_status_manager.dart';
import 'package:academia/notifier/local_notifier_service.dart';

class CoursesBackgroundService {
  static final CoursesBackgroundService _instance =
      CoursesBackgroundService._internal();

  factory CoursesBackgroundService() {
    return _instance;
  }

  /// Private named constructor that prevents external instantiation.
  CoursesBackgroundService._internal();

  void notifyTodaysCourses() {
    CourseModelHelper().queryAll().then((value) {
      int coursestoday = 0;
      value.map((e) {
        final course = Course.fromJson(e);
        if (course.dayOfWeek == DateTime.now().weekdayToString()) {
          coursestoday++;
        }
      });

      if (coursestoday > 0) {
        LocalNotifierService().showNotification(
          id: LocalNotificationStatusManager().getNextId(),
          title: "Class! Class! Class! ${Emojis.building_school}",
          body:
              "Hey, you have $coursestoday classes today ${Emojis.smile_face_screaming_in_fear}",
          channelKey: LocalNotificationChannelType.reminders.channelKey,
        );
      }
    });
  }
}
