import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:academia/tools/anki/pages/flashcards.dart';
import 'package:academia/tools/anki/widgets/widgets.dart';
import 'package:get/get.dart';
import '../models/models.dart';

class StarredTopics extends StatelessWidget {
  const StarredTopics({
    super.key,
    required this.topicId,
    required this.topic,
    required this.desc,
  });

  final int topicId;
  final String topic;
  final String desc;

  @override
  Widget build(BuildContext context) {
    TopicController topicController = Get.find<TopicController>();

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => TopicFlashCards(
            topicId: topicId,
          ),
        ),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.27,
        width: MediaQuery.of(context).size.width * 0.87,
        child: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Positioned(
              top: 9,
              left: 3,
              right: 4,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.267,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Topic",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(topic),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(desc),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 9,
              right: 5,
              left: 150,
              child: Container(
                height: 95,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 10,
                      style: BorderStyle.solid,
                    ),
                    left: BorderSide(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 10,
                      style: BorderStyle.solid,
                    ),
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(500),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 19,
              right: 0,
              child: Row(
                children: [
                  // unfavourite a topic from favourited topics
                  IconButton(
                    onPressed: () async {
                      AnkiTopic topic = AnkiTopic(
                        id: topicId,
                        name: this.topic,
                        desc: desc,
                        isFavourite: true,
                      );
                      await topicController.favouriteTopic(topic);
                      // update favourites and all topics
                      await topicController.getAllFavourites();
                      await topicController.getAllTopics();
                    },
                    icon: const Icon(Ionicons.star),
                  ),
                  // delete for topics
                  IconButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: const Text(
                          "Are You Sure You Want To Delete Topic?",
                        ),
                        actions: [
                          OutlinedButton(
                            onPressed: () async {
                              AnkiTopic topic = AnkiTopic(
                                id: topicId,
                                name: this.topic,
                                desc: desc,
                              );
                              bool? deleted =
                                  await topicController.deleteTopic(topic);

                              HapticFeedback.heavyImpact().then((val) {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: (deleted)
                                        ? const Text(
                                            "Topic Successfully Deleted")
                                        : const Text(
                                            "Damn! We crashed please try again!"),
                                  ),
                                );
                              });
                              // update favourites and all topics
                              await topicController.getAllFavourites();
                              await topicController.getAllTopics();
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                            },
                            child: const Text("Yes, delete it"),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("No"),
                          ),
                        ],
                      ),
                    ),
                    icon: const Icon(Ionicons.trash),
                  )
                ],
              ),
            ),
            const Positioned(
              top: 10,
              left: 16,
              child: CustomEclipse(),
            ),
          ],
        ),
      ),
    );
  }
}
