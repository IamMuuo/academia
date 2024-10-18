import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/models/models.dart';
import 'package:get/get.dart';

class TopicController extends GetxController {
  final RxList<AnkiTopic> allTopics = <AnkiTopic>[].obs;
  final RxList<AnkiTopic> allFavourites = <AnkiTopic>[].obs;

  @override
  void onInit() {
    super.onInit();
    getAllTopics().then((value) {
      debugPrint("[+] Topics Loaded");
    });
    getAllFavourites().then((value) {
      debugPrint("[+] Favourite Topics Loaded");
    });
  }

  // returns the number of topics
  int numTopics() {
    return allTopics.length;
  }

  Future<bool> addTopic(AnkiTopic topic) async {
    int value = await TopicModelHelper().create(topic.toJson());
    return value == 0 ? false : true;
  }

  // Marking topic as favourite and vice versa
  Future<bool> favouriteTopic(AnkiTopic topic) async {
    topic.isFavourite = !topic.isFavourite;
    // update topic list
    if (allFavourites.length >= 5) {
      updateFavourites();
    }
    int value = await TopicModelHelper().update(topic.toJson());
    return value == 0 ? false : true;
  }

  // updating favourite lists by popping one
  void updateFavourites() async {
    // pops the last favourited topic when more than five
    AnkiTopic removedTopic = allFavourites.removeAt(0);
    removedTopic.isFavourite = false;
    // update the topic in db
    await updateTopic(removedTopic);
  }

  // increments topics number of cards by one
  Future<bool> incTopicNumCards(AnkiTopic topic) async {
    topic.numCards++;
    int value = await TopicModelHelper().update(topic.toJson());
    return value == 0 ? false : true;
  }

  // decrements topics number of cards by one
  Future<bool> descTopicNumCards(AnkiTopic topic) async {
    topic.numCards--;
    int value = await TopicModelHelper().update(topic.toJson());
    return value == 0 ? false : true;
  }

  Future<bool> updateTopic(AnkiTopic topic) async {
    int value = await TopicModelHelper().update(topic.toJson());
    return value == 0 ? false : true;
  }

  Future<List<AnkiTopic>> getAllFavourites() async {
    TopicModelHelper().getFavourites().then((values) {
      allFavourites.clear();
      values = values.reversed.toList();
      for (final val in values) {
        allFavourites.add(AnkiTopic.fromJson(val));
      }
    });
    return allFavourites.reversed.toList();
  }

  Future<List<AnkiTopic>> getAllTopics() async {
    TopicModelHelper().queryAll().then((values) {
      allTopics.clear();
      values = values.reversed.toList();
      for (final val in values) {
        allTopics.add(AnkiTopic.fromJson(val));
      }
      update();
    });
    return allTopics;
  }

  Future<bool> deleteTopic(AnkiTopic topic) async {
    int value = await TopicModelHelper().delete(topic.toJson());
    getAllTopics();
    return value == 0 ? false : true;
  }
}
