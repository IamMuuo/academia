import 'package:academia/tools/ask_me/controllers/quizSettings_controller.dart';
import 'package:academia/tools/ask_me/pages/questionScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/models.dart';

class QuizSettings extends StatelessWidget {
  QuizSettings({super.key});

  final QuizSettingsController settingsController = Get.put(QuizSettingsController());
  
  List<Question> questions = [
    Question(
      id: '1',
      question: 'What is the capital of France?',
      choices: ['Berlin', 'Madrid', 'Paris', 'Rome'],
      correctAnswer: 'Paris',
    ),
    Question(
      id: '2',
      question: 'What is the largest planet in our solar system?',
      choices: ['Earth', 'Jupiter', 'Mars', 'Saturn'],
      correctAnswer: 'Jupiter',
    ),
    Question(
      id: '3',
      question: 'What is the chemical symbol for water?',
      choices: ['H2O', 'O2', 'CO2', 'NaCl'],
      correctAnswer: 'H2O',
    ),
    Question(
      id: '4',
      question: 'What is the hardest natural substance on Earth?',
      choices: ['Gold', 'Iron', 'Diamond', 'Platinum'],
      correctAnswer: 'Diamond',
    ),
    Question(
      id: '5',
      question: 'Who wrote "To Kill a Mockingbird"?',
      choices: ['Harper Lee', 'J.K. Rowling', 'Ernest Hemingway', 'Mark Twain'],
      correctAnswer: 'Harper Lee',
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
                _buildChoiceChip('Multiple choice'),
                const SizedBox(width: 10),
                _buildChoiceChip('True/False'),
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
            _buildTimerOptions(),
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

  Widget _buildChoiceChip(String label) {
    return Obx(() => ChoiceChip(
          label: Text(label),
          selected: settingsController.questionType.value == label,
          onSelected: (bool selected) {
            settingsController.setQuestionType(label);
          },
          selectedColor: Colors.pink[100],
          backgroundColor: Colors.grey[100],
        ));
  }

  Widget _buildTimerOptions() {
    return Column(
      children: List.generate(5, (index) {
        int minute = index + 1;
        return GestureDetector(
          onTap: () {
            settingsController.setSelectedTimer(minute);
          },
          child: Obx(
            () => Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15.0),
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              decoration: BoxDecoration(
                color: settingsController.selectedTimer.value == minute
                    ? Colors.pink[50]
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  '$minute minute',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: settingsController.selectedTimer.value == minute
                        ? Colors.black
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
