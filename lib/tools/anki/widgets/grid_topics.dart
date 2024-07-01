import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/pages/flashcards.dart';
import 'package:flutter/material.dart';

class GridViewTopic extends StatelessWidget {
  const GridViewTopic({
    super.key,
    required this.idx,
    required this.topic,
    required this.topicDesc,
  });

  final int idx;
  final String topic;
  final String topicDesc;

  @override
  Widget build(BuildContext context) {
    var colorDet = idx % 4;
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => const TopicFlashCards(),
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
                    GestureDetector(
                      onTap: () => debugPrint("Feature Coming Real Soon"),
                      child: Icon(
                        Icons.star_border_outlined,
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

var test_topics = [
  GridViewTopic(
    idx: 0,
    topic: "ACS 314",
    topicDesc: "This Contains Flash Cards For ACS 314, from first week",
  ),
  GridViewTopic(
    idx: 1,
    topic: "ACS 314",
    topicDesc: "This Contains Flash Cards For ACS 314, from first week",
  ),
  GridViewTopic(
    idx: 2,
    topic: "ACS 314",
    topicDesc: "This Contains Flash Cards For ACS 314, from first week",
  ),
  GridViewTopic(
    idx: 3,
    topic: "ACS 314",
    topicDesc: "This Contains Flash Cards For ACS 314, from first week",
  ),
  GridViewTopic(
    idx: 4,
    topic: "ACS 314",
    topicDesc: "This Contains Flash Cards For ACS 314, from first week",
  ),
  GridViewTopic(
    idx: 5,
    topic: "ACS 314",
    topicDesc: "This Contains Flash Cards For ACS 314, from first week",
  ),
  GridViewTopic(
    idx: 6,
    topic: "ACS 314",
    topicDesc: "This Contains Flash Cards For ACS 314, from first week",
  ),
  GridViewTopic(
    idx: 7,
    topic: "ACS 314",
    topicDesc: "This Contains Flash Cards For ACS 314, from first week",
  ),
  GridViewTopic(
    idx: 8,
    topic: "ACS 314",
    topicDesc: "This Contains Flash Cards For ACS 314, from first week",
  ),
  GridViewTopic(
    idx: 9,
    topic: "ACS 314",
    topicDesc: "This Contains Flash Cards For ACS 314, from first week",
  ),
];
