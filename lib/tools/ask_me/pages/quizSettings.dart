import 'package:academia/tools/ask_me/controllers/quizSettings_controller.dart';
import 'package:academia/tools/ask_me/pages/questionScreen.dart';
import 'package:academia/tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/models.dart';
import '../widgets/widgets.dart';

class HardCodedQuestion {
  String id;
  String question;
  List<String> choices; // Either multple choice ot True/False
  String correctAnswer;

  HardCodedQuestion({
    required this.id,
    required this.question,
    required this.choices,
    required this.correctAnswer,
  });
}

class QuizSettings extends StatelessWidget {
  QuizSettings({super.key});

  final QuizSettingsController settingsController = Get.put(QuizSettingsController());
  
  List<HardCodedQuestion> questions = [
    HardCodedQuestion(
      id: '1',
      question: 'What is the capital of France?',
      choices: ['Berlin', 'Madrid', 'Paris', 'Rome'],
      correctAnswer: 'Paris',
    ),
    HardCodedQuestion(
      id: '2',
      question: 'What is the largest planet in our solar system?',
      choices: ['Earth', 'Jupiter', 'Mars', 'Saturn'],
      correctAnswer: 'Jupiter',
    ),
    HardCodedQuestion(
      id: '3',
      question: 'What is the chemical symbol for water?',
      choices: ['H2O', 'O2', 'CO2', 'NaCl'],
      correctAnswer: 'H2O',
    ),
    HardCodedQuestion(
      id: '4',
      question: 'What is the hardest natural substance on Earth?',
      choices: ['Gold', 'Iron', 'Diamond', 'Platinum'],
      correctAnswer: 'Diamond',
    ),
    HardCodedQuestion(
      id: '5',
      question: 'Who wrote "To Kill a Mockingbird"?',
      choices: ['Harper Lee', 'J.K. Rowling', 'Ernest Hemingway', 'Mark Twain'],
      correctAnswer: 'Harper Lee',
    ),
    HardCodedQuestion(
      id: '6',
      question: 'Which element has the chemical symbol "Au"?',
      choices: ['Silver', 'Gold', 'Iron', 'Copper'],
      correctAnswer: 'Gold',
    ),
    HardCodedQuestion(
      id: '7',
      question: 'What is the largest ocean on Earth?',
      choices: ['Atlantic Ocean', 'Indian Ocean', 'Arctic Ocean', 'Pacific Ocean'],
      correctAnswer: 'Pacific Ocean',
    ),
    HardCodedQuestion(
      id: '8',
      question: 'Who painted the Mona Lisa?',
      choices: ['Vincent van Gogh', 'Leonardo da Vinci', 'Pablo Picasso', 'Claude Monet'],
      correctAnswer: 'Leonardo da Vinci',
    ),
    HardCodedQuestion(
      id: '9',
      question: 'What is the smallest prime number?',
      choices: ['0', '1', '2', '3'],
      correctAnswer: '2',
    ),
    HardCodedQuestion(
      id: '10',
      question: 'Which planet is known as the Red Planet?',
      choices: ['Venus', 'Mars', 'Mercury', 'Neptune'],
      correctAnswer: 'Mars',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.close,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Choose the question type and set a timer.',
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 40.0),
            const Text(
              'Question type',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                ChoiceWidget(label: 'Multiple choice'),
                const SizedBox(width: 10),
                ChoiceWidget(label: 'True/False'),
              ],
            ),
            const SizedBox(height: 40.0),
            const Text(
              'Timer',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            TimerOptions(),
            const SizedBox(height: 20.0),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                    context, 
                      MaterialPageRoute(builder: (context) => QuestionScreen(questions: questions,))
                    );
                   }, 
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                    backgroundColor: Colors.lightBlue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    ),
                    child: const Text(
                      'Start quiz',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
