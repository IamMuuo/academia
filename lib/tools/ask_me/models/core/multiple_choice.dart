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

