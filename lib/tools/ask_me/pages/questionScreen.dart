import 'dart:async';
import 'package:academia/tools/ask_me/controllers/quizSettings_controller.dart';
import 'package:academia/tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionScreen extends StatefulWidget {
  final List<HardCodedQuestion> questions;
  const QuestionScreen({super.key, required this.questions});

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
  int score = 0;
  late Timer _timer;
  int _totalTime = 0; 
  int _timeLeft = 0;

  @override
  void initState() {
    super.initState();

    final quizSettingsController = Get.find<QuizSettingsController>();
     _totalTime = quizSettingsController.minute.value * 60 + quizSettingsController.seconds.value; // use minutes and seconds
    _timeLeft = _totalTime;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer.cancel();
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => ScoreSection(score: score)),
            );
        }
      });
     });
  }

  @override
  void dispose() {
    _timer.cancel(); //Cancelling the timer when the widget is disposed
    super.dispose();
  }

  void _submitAnswer() {
    if (selectedOptionIndex == null) return;

    setState(() {
      isAnswered = true;
      correctAnswer = widget.questions[currentIndex].correctAnswer;
      if (widget.questions[currentIndex].choices[selectedOptionIndex!] == correctAnswer) {
        score++;
      }
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
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ScoreSection(score: score)),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= widget.questions.length) {
      return ScoreSection(score: score,);
    }

    HardCodedQuestion currentQuestion = widget.questions[currentIndex];
    int minutes = _timeLeft ~/ 60;
    int seconds = _timeLeft % 60;

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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                      Text(
                        "${currentIndex + 1} of ${widget.questions.length}",
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LinearProgressIndicator(
                    value: progressvalue / widget.questions.length,
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
                    onPressed: isNextButton
                        ? (currentIndex == widget.questions.length - 1 ? () {
                            setState(() {
                              isNextButton = false; 
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => ScoreSection(score: score)),
                              );
                            });
                          } : _nextQuestion)
                        : _submitAnswer,
                    child: Text(
                      isNextButton
                          ? (currentIndex == widget.questions.length - 1 ? "Score" : "Next")
                          : "Submit",
                    ),
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
