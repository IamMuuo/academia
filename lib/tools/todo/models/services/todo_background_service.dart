import 'package:academia/exports/barrel.dart';
import 'package:academia/notifier/local_notification_channel.dart';
import 'package:academia/notifier/local_notification_status_manager.dart';
import 'package:academia/notifier/local_notifier_service.dart';

class TodoBackgroundService {
  static final TodoBackgroundService _instance =
      TodoBackgroundService._internal();

  factory TodoBackgroundService() {
    return _instance;
  }

  /// Private named constructor that prevents external instantiation.
  TodoBackgroundService._internal();

  void notifyPendingTasks() {
    TodoModelHelper().queryAll().then((value) {
      value.map((e) {
        final todo = Todo.fromJson(e);

        if ((!todo.complete) && todo.notify == true) {
          LocalNotifierService().showNotification(
            id: LocalNotificationStatusManager().getNextId(),
            title: "Todos ${Emojis.smile_skull}",
            body: "Todo ${todo.name} requires your attention",
            channelKey: LocalNotificationChannelType.reminders.channelKey,
          );
        }
      });
    });
  }
}
