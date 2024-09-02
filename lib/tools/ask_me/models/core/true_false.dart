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
    final question = json.keys.first;
    final answer = json[question];
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

//True or False Quiz model
class TrueFalseQuiz {
  List<TrueFalseQuestion> questions;

  TrueFalseQuiz({required this.questions});

  factory TrueFalseQuiz.fromJson(Map<String, dynamic> json) {
    return TrueFalseQuiz(
      questions: List<TrueFalseQuestion>.from(
        json['questions'].map((questionJson) => TrueFalseQuestion.fromJson(questionJson)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }
}
