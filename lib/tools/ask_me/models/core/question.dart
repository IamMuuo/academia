// //Get from backend
// class Question {
//   final String question;
//   final List<String> choices; // Either multple choice ot True/False
//   final String correctAnswer;

//   Question({
//     required this.question,
//     required this.choices,
//     required this.correctAnswer,
//   });

//   factory Question.fromJson(Map<String, dynamic> json) {
//     return Question(
//       question: json['question'], 
//       choices: List<String>.from(json['choices'] ?? []), 
//       correctAnswer: json['correct_answer'],
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'question': question,
//       'choices': choices,
//       'correct_answer': correctAnswer,
//     };
//   }
// }

class Question {
  String id;
  String question;
  List<String> choices; // Either multple choice ot True/False
  String correctAnswer;

  Question({
    required this.id,
    required this.question,
    required this.choices,
    required this.correctAnswer,
  });
}




