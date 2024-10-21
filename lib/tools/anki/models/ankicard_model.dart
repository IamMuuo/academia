// ankiTCard model

class AnkiCard {
  int? id;
  int topicId;
  String question;
  String answer;

  AnkiCard({
    this.id,
    required this.topicId,
    required this.question,
    required this.answer,
  });

  AnkiCard.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        topicId = json['topic_id'],
        question = json['question'],
        answer = json['answer'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'topic_id': topicId,
        'question': question,
        'answer': answer,
      };
}
