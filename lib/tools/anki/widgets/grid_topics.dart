import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:academia/tools/anki/models/models.dart';
import 'package:academia/tools/anki/pages/flashcards.dart';
import 'package:flutter/material.dart';

class GridViewTopic extends StatelessWidget {
  const GridViewTopic({
    super.key,
    required this.idx,
    required this.topic,
    required this.topicDesc,
    required this.isFavourite,
    this.controller,
  });

  final int idx;
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
              ? const Color(0xff8999aa)
              : colorDet == 1
                  ? const Color(0xffffcdfe)
                  : colorDet == 2
                      ? const Color(0xffffe7cd)
                      : const Color(0xffcdffce),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                topic,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                topicDesc,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                width: MediaQuery.of(context).size.width * 0.2,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => debugPrint("Feature Coming Real Soon"),
                      child: Icon(
                        Icons.play_arrow,
                        size: MediaQuery.of(context).size.height * 0.041,
                      ),
                    ),
                    // favourite a topic
                    GestureDetector(
                      onTap: () async {
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
                        // TODO tell user that the topic has been favourited
                      },
                      child: Icon(
                        isFavourite ? Icons.star : Icons.star_border_outlined,
                        size: MediaQuery.of(context).size.height * 0.035,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
