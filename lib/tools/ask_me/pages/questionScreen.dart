import 'package:flutter/material.dart';
import '../models/models.dart';

class QuestionScreen extends StatefulWidget {
  final List<Question> questions;
  const QuestionScreen({super.key, required this.questions,});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int currentIndex = 0;
  int? selectedOptionIndex;
  bool isAnswered = false;
  int progressvalue = 1;
  String? correctAnswer; 
  bool isNextButton = false;

  void _submitAnswer() {
    if (selectedOptionIndex == null) return;

    setState(() {
      isAnswered = true;
      correctAnswer = widget.questions[currentIndex].correctAnswer;
      isNextButton = true;
    });

  }

  void _nextQuestion() {
    setState(() {
      if (currentIndex < widget.questions.length - 1) {
        currentIndex++;
        selectedOptionIndex = null;
        isAnswered = false;
        progressvalue++;
        correctAnswer = null;
        isNextButton = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= widget.questions.length) {
      return const Scaffold(
        body: Center(
          child: Text('Quiz Completed!'),
        ),
      );
    }


    Question currentQuestion = widget.questions[currentIndex];

 

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 30, 16, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Text(
                        "${currentIndex + 1} of 10",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const Text(
                        "01:40",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LinearProgressIndicator(
                    value: progressvalue / 10,
                    minHeight: 10,
                    backgroundColor: const Color(0xFF006399),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF934171)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: const Color(0xFF006399),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        currentQuestion.question,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      ...List.generate(currentQuestion.choices.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedOptionIndex = index;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 6.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: selectedOptionIndex == index
                                  ? Colors.blue.shade100
                                  : Colors.white,
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Radio<int>(
                                  value: index,
                                  groupValue: selectedOptionIndex,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOptionIndex = value;
                                    });
                                  },
                                ),
                                Expanded(
                                  child: Text(
                                    currentQuestion.choices[index],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                if (isAnswered)
                                  Icon(
                                    currentQuestion.choices[index] == currentQuestion.correctAnswer
                                        ? Icons.check
                                        : Icons.close,
                                    color: currentQuestion.choices[index] == currentQuestion.correctAnswer
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                  
                              ],
                            ),
                          ),
                        );
                      }),
                      if (isAnswered) 
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Correct Answer:\n'
                                '$correctAnswer',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        )
                      
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFF006399),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: isNextButton ? _nextQuestion: _submitAnswer,
                    child: Text(isNextButton ? "Next" :"Submit"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
