import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../stories.dart';

class HomeScreenStoryWidget extends StatelessWidget {
  const HomeScreenStoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final storyController = Get.find<StoryController>();
    return Obx(
      () => Container(
        height: 80,
        padding: const EdgeInsets.all(8),
        child: ListView.separated(
          itemBuilder: (context, index) {
            final org = storyController.stories.keys.elementAt(index);
            final storys = storyController.stories[org];
            if (storys!.isEmpty) {
              return const SizedBox();
            }
            return OrganizationProfilePicture(
              organization: org,
              stories: storys,
            );
          },
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemCount: storyController.stories.keys.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
        ),
      ),
    );
  }
}
