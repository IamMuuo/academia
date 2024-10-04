import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:academia/tools/anki/widgets/starred_topic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/grid_topics.dart';

class PopulatedAnkiHomeScreen extends StatelessWidget {
  const PopulatedAnkiHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TopicController topicController = Get.find<TopicController>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // displays favourite topics
          Obx(
            () => Visibility(
              visible: topicController.allFavourites.isNotEmpty,
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  height: MediaQuery.of(context).size.height * 0.27,
                  width: MediaQuery.of(context).size.width * 0.87,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, idx) {
                      return StarredTopics(
                        idx: topicController.allFavourites[idx].id!,
                        topic: topicController.allFavourites[idx].name,
                        desc: topicController.allFavourites[idx].desc,
                        topicController: topicController,
                      );
                    },
                    itemCount: topicController.allFavourites.length,
                  ),
                ),
              ),
            ),
          ),
          // displays topicics
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            padding: const EdgeInsets.all(12),
            child: Obx(
              () => GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, idx) {
                  return GridViewTopic(
                    idx: idx,
                    topicId: topicController.allTopics[idx].id!,
                    topic: topicController.allTopics[idx].name,
                    topicDesc: topicController.allTopics[idx].desc,
                    isFavourite: topicController.allTopics[idx].isFavourite,
                    // controller: topicController,
                  );
                },
                itemCount: topicController.allTopics.length,
                scrollDirection: Axis.vertical,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
