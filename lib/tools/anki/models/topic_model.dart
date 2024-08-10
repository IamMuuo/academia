// ankiTopic model

class AnkiTopic {
  int? id;
  String desc;
  bool isFavourite;
  int numCards;

  AnkiTopic({
    this.id,
    required this.desc,
    this.isFavourite = false,
    this.numCards = 0,
  });

  AnkiTopic.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        desc = json['desc'],
        isFavourite = json['is_favourite'],
        numCards = json['num_cards'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'desc': desc,
        'is_favourite': isFavourite,
        'num_cards': numCards,
      };
}
