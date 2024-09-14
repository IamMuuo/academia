import 'package:academia/exports/barrel.dart';

// background services
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case BackgroundConfig.refresh:
        debugPrint("hey");
        break;
      default:
    }
    // notificationsController.createInstantNotification(
    //   "Hello there",
    //   "Hello again son",
    // );
    // notificationsController.scheduleNotification(
    //   DateTime.now().add(Duration(minutes: 1)),
    //   "Test",
    //   "This is a mF big text notification",
    //   notificationLayout: NotificationLayout.BigText,
    // );
    return Future.value(true);
  });
}
