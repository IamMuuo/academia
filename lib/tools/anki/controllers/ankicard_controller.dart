import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/models/models.dart';
import 'package:get/get.dart';

class AnkiCardController extends GetxController {
  AnkiCardController({
    required this.topicId,
  });

  final RxList<AnkiCard> allCards = <AnkiCard>[].obs;
  final int topicId;

  @override
  void onInit() {
    super.onInit();
    getAllTopicCards().then((value) {
      debugPrint("[+] Anki Topic Cards Loaded");
    });
  }

  // returns the number of topics
  int numAnkiCards() {
    return allCards.length;
  }

  Future<bool> addAnkiCard(AnkiCard ankiCard) async {
    int value = await AnkiCardModelHelper().create(ankiCard.toJson());
    return value == 0 ? false : true;
  }

  Future<bool> updateAnkiCard(AnkiCard ankiCard) async {
    int value = await AnkiCardModelHelper().update(ankiCard.toJson());
    return value == 0 ? false : true;
  }

  Future<List<AnkiCard>> getAllTopicCards() async {
    AnkiCardModelHelper().queryAnkiCardsByTopic(topicId).then((values) {
      allCards.clear();
      values = values.reversed.toList();
      for (final val in values) {
        allCards.add(AnkiCard.fromJson(val));
      }
    });
    return allCards;
  }

  Future<bool> deleteCard(AnkiCard ankiCard) async {
    int value = await AnkiCardModelHelper().delete(ankiCard.toJson());
    getAllTopicCards();
    return value == 0 ? false : true;
  }
}
