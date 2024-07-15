import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import '../models/models.dart';

class StoryViewPage extends StatelessWidget {
  const StoryViewPage({
    super.key,
    required this.organization,
    required this.stories,
  });
  final Organization organization;
  final List<Story> stories;

  List<StoryItem> buildStories(StoryController c) {
    if (stories.isEmpty) {
      return [
        StoryItem.text(
          title: "Error",
          backgroundColor: Colors.red,
        )
      ];
    }

    final List<StoryItem> items = <StoryItem>[];

    for (var story in stories) {
      if (story.media == null) {
        items.add(
          StoryItem.text(title: story.text, backgroundColor: Colors.blueGrey),
        );
        continue;
      }

      if (story.media!.toLowerCase().endsWith(".mp4")) {
        items.add(
          StoryItem.pageVideo(
            story.media!,
            controller: c,
            caption: Text(
              story.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
        continue;
      }

      if (story.media!.toLowerCase().endsWith(".png") ||
          story.media!.toLowerCase().endsWith(".jpeg") ||
          story.media!.endsWith(".jpg") ||
          story.media!.endsWith(".gif")) {
        items.add(
          StoryItem.inlineImage(
            url: story.media!,
            controller: c,
            imageFit: BoxFit.fitWidth,
            caption: Text(
              story.text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        );
        continue;
      }
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final sc = StoryController();
    return Scaffold(
      appBar: AppBar(
        title: Text(organization.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: StoryView(
        inline: false,
        onComplete: () {
          Navigator.pop(context);
        },
        onStoryShow: (storyItem, index) {},
        storyItems: buildStories(sc),
        controller: sc,
      ),
    );
  }
}
