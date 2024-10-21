import '../models.dart';

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