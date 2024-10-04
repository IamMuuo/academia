import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:academia/tools/anki/models/models.dart';
import 'package:academia/tools/anki/pages/flashcards.dart';

class GridViewTopic extends StatelessWidget {
  const GridViewTopic({
    super.key,
    required this.idx,
    required this.topicId,
    required this.topic,
    required this.topicDesc,
    required this.isFavourite,
    this.controller,
  });

  final int idx;
  final int topicId;
  final String topic;
  final String topicDesc;
  final bool isFavourite;
  final TopicController? controller;

  @override
  Widget build(BuildContext context) {
    var colorDet = idx % 4;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => TopicFlashCards(
            topicId: idx,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colorDet == 0
              ? Theme.of(context).colorScheme.primaryContainer
              : colorDet == 1
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : colorDet == 2
                      ? Theme.of(context).colorScheme.tertiaryContainer
                      : Theme.of(context).colorScheme.errorContainer,
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              topic,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              topicDesc,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // favourite a topic
                IconButton(
                  onPressed: () async {
                    // create a topic object
                    AnkiTopic topic = AnkiTopic(
                      id: idx,
                      name: this.topic,
                      desc: topicDesc,
                      isFavourite: isFavourite,
                    );
                    await controller?.favouriteTopic(topic);
                    // update favourites and all topics
                    await controller?.getAllFavourites();
                    await controller?.getAllTopics();
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: !isFavourite
                            ? const Text("Topic Successfully Favourited")
                            : const Text("Topic Successfully Unfavourited"),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  icon: Icon(
                    isFavourite ? Icons.star : Icons.star_border_outlined,
                  ),
                ),
                // delete for topics
                IconButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Confirmation"),
                      content: const Text(
                        "Are you sure you want to delete topic?",
                      ),
                      actions: [
                        OutlinedButton(
                          onPressed: () async {
                            AnkiTopic topic = AnkiTopic(
                              id: idx,
                              name: this.topic,
                              desc: topicDesc,
                            );
                            bool? deleted =
                                await controller?.deleteTopic(topic);
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: (deleted != null && deleted)
                                    ? const Text("Topic Successfully Deleted")
                                    : const Text(
                                        "Something happened! Kindly Retry!!"),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                            // update favourites and all topics
                            await controller?.getAllFavourites();
                            await controller?.getAllTopics();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          },
                          child: const Text("Yes"),
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
                  icon: const Icon(
                    Icons.delete,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
