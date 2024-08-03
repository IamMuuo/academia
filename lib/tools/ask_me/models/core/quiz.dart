//What needs to be posted
class Quiz{
  final String prompt;
  final String questionType;

  Quiz({
    required this.prompt,
    required this.questionType,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      prompt: json['prompt'], 
      questionType: json['question_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': prompt,
      'question_type': questionType,
    };
  }
}
