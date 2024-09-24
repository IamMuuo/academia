import 'package:academia/exports/barrel.dart';

// background services
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case BackgroundConfig.todosIDentifier:
        TodoBackgroundService().notifyPendingTasks();
        break;
      case BackgroundConfig.coursesIDentifier:
        CoursesBackgroundService().notifyTodaysCourses();
        break;
      default:
    }
    return Future.value(true);
  });
}

Duration timeUntilNextTarget(DateTime targetTime) {
  DateTime now = DateTime.now();
  Duration difference = targetTime.difference(now);
  return difference;
}

class BackgroundWorker {
  static final BackgroundWorker _instance = BackgroundWorker._internal();

  factory BackgroundWorker() {
    return _instance;
  }

  /// Private named constructor that prevents external instantiation.
  BackgroundWorker._internal();

  Future<void> initialize() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: true,
      );

      DateTime now = DateTime.now();

      /// Courses background service
      Workmanager().registerPeriodicTask(
        BackgroundConfig.coursesIDentifier,
        BackgroundConfig.coursesIDentifier,
        initialDelay: timeUntilNextTarget(
          DateTime(now.year, now.month, now.day, 12, 0, 0),
        ),
        frequency: const Duration(minutes: 15),
      );

      /// Todos task that is suppossed to run after every 24 hours at 8 am
      Workmanager().registerPeriodicTask(
        BackgroundConfig.todosIDentifier,
        BackgroundConfig.todosIDentifier,
        initialDelay: const Duration(seconds: 10),
        frequency: const Duration(minutes: 15),
      );
    }
  }
}
