import '../models.dart';

class Quiz {
  final List<Question> questions;

  Quiz({required this.questions});
  
  // Factory method to create a Quiz from JSON
  factory Quiz.fromJson(Map<String, dynamic> json) {
    var questionsJson = json['questions'] as List;
    List<Question> questionList = questionsJson.map((q) => Question.fromJson(q)).toList();

    return Quiz(questions: questionList);
  }

  // Convert the Quiz object to JSON
  Map<String, dynamic> toJson() {
    return {
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}

