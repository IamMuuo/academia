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
            // element["upload_url"],
            "https://youtu.be/TO-_3tck2tg?si=5qXx5ajeV7_aKqfD",
            // caption: element["contents"],
            caption: "Academia loves you",
            controller: storyController,
          ));
          break;

        case "image":
          items.add(StoryItem.pageImage(
            // caption: element["contents"],
            caption: "Academia is for you by you",
            // url: element["upload_url"],
            url:
                "https://i.pinimg.com/236x/87/94/51/87945156541bf6d116c5b5d5e49a6acf.jpg",
            controller: storyController,
          ));
          break;

        default:
          items.add(
            StoryItem.text(
              // title: element["contents"],
              title: "Wtf",
              backgroundColor: getRandomColor(),
            ),
          );
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    var notifications = Get.find<NotificationsController>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_left),
        ),
        title: Text(user.name!.split(" ")[0].title()),
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
                  StoryItem.pageImage(
                    // caption: element["contents"],
                    caption: "Academia is for you by you",
                    // url: element["upload_url"],
                    url:
                        "https://i.pinimg.com/236x/87/94/51/87945156541bf6d116c5b5d5e49a6acf.jpg",
                    controller: storyController,
                  ),
                  StoryItem.text(
                    // title: element["contents"],
                    title: "It's magic",
                    backgroundColor: getRandomColor(),
                  ),
                  StoryItem.pageVideo(
                    // element["upload_url"],
                    "https://dl207v.filemate16.shop/?file=M3R4SUNiN3JsOHJ6WWQ2a3NQS1Y5ZGlxVlZIOCtyZ0lsOUk5emg0a1NxSkM3WXdoMDYrc0xNNUlKNmtJaG9XM0JaVkgvVEhLWmNPMFlWL1I1b2hvVDJQVnNkQTB0VHJ3NDQ4MFVaUTBCRERobFBPM2d6Tnp6RlhUYzhpWlVPcHdPVElwaFZCVGd3ZWJ5Y0RWc1Qyc2pDejkveDJUSWlrYTVuME1PUHFOMnJvTzBISGJadVhoeDVrSXFIdk90Y29lamFQTDdGR2xoYUUzb3Rrb0R4QWtKTU1LZ2R6bXlhM0lweDQ9",
                    // "https://youtu.be/dVq-lzhwmPw?si=XUpyU9zWPo10XoP5",
                    // caption: element["contents"],
                    caption: "Academia loves you",
                    controller: storyController,
                  ),
                ],
                controller: storyController,
              ),
      ),
    );
  }
}
