import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/models/models.dart';
import 'package:get/get.dart';

class TopicController extends GetxController {
  final RxList<AnkiTopic> allTopics = <AnkiTopic>[].obs;
  // TODO getting favourite topics

  @override
  void onInit() {
    super.onInit();
    getAllTopics().then((value) {
      debugPrint("[+] Topics Loaded");
    });
  }

  Future<bool> addTopic(AnkiTopic topic) async {
    int value = await TopicModelHelper().create(topic.toJson());
    return value == 0 ? false : true;
  }

  // Marking topic as favourite and vice versa
  Future<bool> favouriteTopic(AnkiTopic topic) async {
    topic.isFavourite = !topic.isFavourite;
    int value = await TodoModelHelper().update(topic.toJson());
    return value == 0 ? false : true;
  }

  // increments topics number of cards by one
  Future<bool> incTopicNumCards(AnkiTopic topic) async {
    topic.numCards++;
    int value = await TodoModelHelper().update(topic.toJson());
    return value == 0 ? false : true;
  }

  // decrements topics number of cards by one
  Future<bool> descTopicNumCards(AnkiTopic topic) async {
    topic.numCards--;
    int value = await TodoModelHelper().update(topic.toJson());
    return value == 0 ? false : true;
  }

  Future<bool> updateTopic(AnkiTopic topic) async {
    int value = await TodoModelHelper().update(topic.toJson());
    return value == 0 ? false : true;
  }

  Future<List<AnkiTopic>> getAllTopics() async {
    TopicModelHelper().queryAll().then((values) {
      allTopics.clear();
      for (final val in values) {
        allTopics.add(AnkiTopic.fromJson(val));
      }
    });
    return allTopics;
  }

  Future<bool> deleteTopic(AnkiTopic topic) async {
    int value = await TopicModelHelper().delete(topic.toJson());
    getAllTopics();
    return value == 0 ? false : true;
  }
}
