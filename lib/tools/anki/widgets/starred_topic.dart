import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:academia/tools/anki/pages/flashcards.dart';
import 'package:academia/tools/anki/widgets/widgets.dart';
import '../models/models.dart';

class StarredTopics extends StatelessWidget {
  const StarredTopics({
    super.key,
    required this.idx,
    required this.topic,
    required this.desc,
    this.topicController,
  });

  final int idx;
  final String topic;
  final String desc;
  final TopicController? topicController;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => TopicFlashCards(
            topicId: idx,
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
                decoration: const BoxDecoration(
                  color: Color(0xffe5ffcd),
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Topic",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(topic),
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
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
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xff444c55),
                      width: 10,
                      style: BorderStyle.solid,
                    ),
                    left: BorderSide(
                      color: Color(0xff444c55),
                      width: 10,
                      style: BorderStyle.solid,
                    ),
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(500),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 19,
              right: 0,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        AnkiTopic topic = AnkiTopic(
                          id: idx,
                          name: this.topic,
                          desc: desc,
                          isFavourite: true,
                        );
                        await topicController?.favouriteTopic(topic);
                        // update favourites and all topics
                        await topicController?.getAllFavourites();
                        await topicController?.getAllTopics();
                      },
                      child: Icon(
                        Icons.star,
                        size: MediaQuery.of(context).size.height * 0.035,
                      ),
                    ),
                    // delete for topics
                    GestureDetector(
                      onTap: () => showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: const Text(
                            "Are You Sure You Want To Delete Topic?",
                          ),
                          actions: [
                            TextButton(
                              style: ButtonStyle(
                                foregroundColor: WidgetStatePropertyAll(
                                  lightColorScheme.error,
                                ),
                              ),
                              onPressed: () async {
                                AnkiTopic topic = AnkiTopic(
                                  id: idx,
                                  name: this.topic,
                                  desc: desc,
                                );
                                bool? deleted =
                                    await topicController?.deleteTopic(topic);
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: (deleted != null && deleted)
                                        ? const Text(
                                            "Topic Successfully Deleted")
                                        : const Text(
                                            "Something happened! Kindly Retry!!"),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                                // update favourites and all topics
                                await topicController?.getAllFavourites();
                                await topicController?.getAllTopics();
                                // ignore: use_build_context_synchronously
                                Navigator.of(context).pop();
                              },
                              child: const Text("Yes"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("No"),
                            ),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.delete,
                        size: MediaQuery.of(context).size.height * 0.035,
                      ),
                    )
                  ],
                ),
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
