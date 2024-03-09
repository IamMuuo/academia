import 'dart:math';

import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:story_view/story_view.dart';

class NotificationsStoryPage extends StatelessWidget {
  const NotificationsStoryPage({super.key, required this.storyController});

  final StoryController storyController;

  Color getRandomColor() {
    const colors = [
      Colors.blueGrey,
      Colors.teal,
      Colors.brown,
      Colors.green,
      Colors.purple,
      Colors.amber
    ];
    var r = Random(DateTime.now().millisecond);
    var x = r.nextInt(colors.length);
    return colors[x];
  }

  List<StoryItem> _buildStoryItems(NotificationsController notifications) {
    List<StoryItem> items = [];

    for (var element in notifications.notifications) {
      switch (element["file_type"].toString().replaceAll('"', "")) {
        case "video":
          items.add(StoryItem.pageVideo(
            element["upload_url"],
            caption: element["contents"] ?? "By academia",
            controller: storyController,
            duration: const Duration(seconds: 30),
          ));
          break;

        case "image":
          items.add(StoryItem.pageImage(
            caption: element["contents"] ?? "Powered by academia",
            url: element["upload_url"],
            controller: storyController,
            duration: const Duration(seconds: 10),
          ));
          break;

        default:
          items.add(
            StoryItem.text(
              title: element["contents"] ?? "Notifications powered by academia",
              backgroundColor: getRandomColor(),
              duration: const Duration(seconds: 10),
            ),
          );
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    var notifications = Get.find<NotificationsController>();
    final UserController userController = Get.find<UserController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_left),
        ),
        title: Text(userController.user.value!.name!.split(" ")[0].title()),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Obx(
        () => notifications.hasNotifications.value
            ? StoryView(
                storyItems: _buildStoryItems(notifications),
                repeat: false,
                controller: storyController,
              )
            : StoryView(
                storyItems: [
                  StoryItem.text(
                    title:
                        "You are seeing this story because something went wrong while fetching stories",
                    backgroundColor: Colors.red,
                    roundedTop: false,
                  ),
                ],
                controller: storyController,
              ),
      ),
    );
  }
}
