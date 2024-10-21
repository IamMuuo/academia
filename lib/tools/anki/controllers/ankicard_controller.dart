import 'package:academia/tools/anki/models/models.dart';
import 'package:get/get.dart';

class AnkiCardController extends GetxController {
  final RxList<AnkiCard> allCards = <AnkiCard>[].obs;

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

  Future<List<AnkiCard>> getAllTopicCards(int topicId) async {
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
    getAllTopicCards(ankiCard.topicId);
    return value == 0 ? false : true;
  }
}
