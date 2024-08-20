import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

// background services
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case BackgroundConfig.refresh:
        final StoryController storyController = Get.find<StoryController>();
        final NotificationsController notificationsController =
            Get.find<NotificationsController>();
        storyController.fetchStories().then(
          (value) {
            value.fold((l) {
              print("You pussy $l");
            }, (r) {
              notificationsController.createInstantNotification(
                "Hey there you!",
                "You have new stories that you havent viewed",
                layout: NotificationLayout.Inbox,
              );
            });
          },
        );
        print("hey");
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
