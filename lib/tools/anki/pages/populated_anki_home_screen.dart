import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:academia/tools/anki/models/models.dart';
import 'package:academia/tools/anki/widgets/starred_topic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Starred Topics",
            ),
          ),
          topicController.allFavourites.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.27,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.18,
                        child: Lottie.asset(
                          "assets/lotties/empty.json",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "You Have No Favourite Topics, Favourite A Topic To Find It Easily",
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )
              : Align(
                  alignment: Alignment.center,
                  child: SizedBox(
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
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CreateTopicWidget(
                topicController: topicController,
              ),
            ),
          ),
          // displays topicics
          // displayed in a grid view if they are more than five
          topicController.allTopics.length <= 5
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Lottie.asset(
                        "assets/lotties/empty.json",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Once you have more than five topics, they’ll pop into a cool grid view! Don’t forget to star your favorites for quick access—but heads up, you can only star five at a time. If you add a new one, the oldest star gets bumped! ⭐",
                        style: Theme.of(context).textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.52,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                          isFavourite:
                              topicController.allTopics[idx].isFavourite,
                          controller: topicController,
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

// widget for creating a topic
class CreateTopicWidget extends StatelessWidget {
  const CreateTopicWidget({
    super.key,
    required this.topicController,
  });

  final TopicController topicController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            final TextEditingController titleController =
                TextEditingController();
            final TextEditingController descController =
                TextEditingController();
            return AlertDialog(
              title: const Text("Create Topic"),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Topic"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 8.0,
                      ),
                      child: TextField(
                        controller: titleController,
                        maxLength: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const Text("Topic Description"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 8.0,
                      ),
                      child: TextField(
                        controller: descController,
                        maxLength: 54,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText:
                              "This Contains Flash Cards For [Topic Name]",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).colorScheme.errorContainer),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isEmpty ||
                        descController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("All Above Fields are required"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    } else if (titleController.text.trim().length <= 3) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Topic Length should be more than 2 characters"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    } else if (descController.text.trim().length <= 12) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "Desc Length should be more than 11 characters"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    } else {
                      // create topic
                      AnkiTopic ankiTopic = AnkiTopic(
                        name: titleController.text,
                        desc: descController.text,
                      );
                      // add to database
                      if (topicController.numTopics() <= 5) {
                        ankiTopic.isFavourite = true;
                      }
                      topicController.addTopic(ankiTopic);

                      if (topicController.numTopics() < 5) {
                        // updating favourites
                        topicController.getAllFavourites();
                      }
                      // updating topic list and favorites
                      topicController.getAllTopics();
                      topicController.getAllFavourites();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("create"),
                ),
              ],
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
      ),
      child: const Text(
        "Create Topic",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}