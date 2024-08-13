// ankiTopic model

class AnkiTopic {
  int? id;
  String name;
  String desc;
  bool isFavourite;
  int numCards;

  AnkiTopic({
    this.id,
    required this.name,
    required this.desc,
    this.isFavourite = false,
    this.numCards = 0,
  });

  AnkiTopic.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        desc = json['desc'],
        isFavourite = json['is_favourite'] == 0 ? false : true,
        numCards = json['num_cards'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'desc': desc,
        'is_favourite': isFavourite ? 1 : 0,
        'num_cards': numCards,
      };
}
