class TrueFalseQuestion {
  String question;
  List<String> choices;
  String answer;

  TrueFalseQuestion({
    required this.question,
    this.choices = const ['True', 'False'],
    required this.answer,
  });

  factory TrueFalseQuestion.fromJson(Map<String, dynamic> json) {
    final question = json[json.keys.first];
    final answer = json[json.keys.toList()[1]];
    return TrueFalseQuestion(
      question: question,
      answer: answer,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'answer': answer,
    };
  }
}
