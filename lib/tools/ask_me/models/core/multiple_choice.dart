class MultipleChoiceQuestion{
  String question;
  List<String> choices;
  String correctAnswer;

  MultipleChoiceQuestion({
    required this.question,
    required this.choices,
    required this.correctAnswer,
  });

  factory MultipleChoiceQuestion.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceQuestion(
      question: json['question'], 
      choices: List<String>.from(json['multiple_choice']), 
      correctAnswer: json['correct_answer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'multiple_choice': choices,
      'correct_answer': correctAnswer,
    };
  }
}

//Multiple choice Quiz model
class MultipleChoiceQuiz {
  List<MultipleChoiceQuestion> questions;

  MultipleChoiceQuiz({required this.questions});

  factory MultipleChoiceQuiz.fromJson(Map<String, dynamic> json) {
    return MultipleChoiceQuiz(
      questions: List<MultipleChoiceQuestion>.from(
        json['questions'].map((questionJson) => MultipleChoiceQuestion.fromJson(questionJson)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }
}
