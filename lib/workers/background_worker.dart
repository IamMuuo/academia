import 'package:academia/exports/barrel.dart';
import 'package:academia/notifier/local_notification_channel.dart';
import 'package:academia/notifier/local_notification_status_manager.dart';
import 'package:academia/notifier/local_notifier_service.dart';

// background services
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case BackgroundConfig.todosIDentifier:
        TodoBackgroundService().notifyPendingTasks();
        break;
      default:
    }
    LocalNotifierService().showNotification(
      id: LocalNotificationStatusManager().getNextId(),
      title: "Dick",
      body: "How are you doing pussy",
      channelKey: LocalNotificationChannelType.general.channelKey,
    );
    return Future.value(true);
  });
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
