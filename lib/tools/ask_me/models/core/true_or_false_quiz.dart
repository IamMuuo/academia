import '../models.dart';

class TrueFalseQuiz {
  List<TrueFalseQuestion> questions;

  TrueFalseQuiz({required this.questions});

  factory TrueFalseQuiz.fromJson(Map<String, dynamic> json) {
    return TrueFalseQuiz(
      questions: List<TrueFalseQuestion>.from(
        json['questions'].map((questionJson) {
          return TrueFalseQuestion.fromJson(questionJson);
        }),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }
}
