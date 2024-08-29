import 'dart:async';
import 'package:academia/tools/tools.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/controllers.dart';
import '../models/models.dart';

class QuestionScreen extends StatefulWidget {
  final MultipleChoiceQuiz? multipleChoiceQuiz;
  final TrueFalseQuiz? trueFalseQuiz;
  final int? id;
  final String title;
  final String filePath;
  const QuestionScreen({
    super.key, 
    this.multipleChoiceQuiz,
    this.trueFalseQuiz,
    this.id,
    required this.title,
    required this.filePath,
  });

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
  List <int> scores = [];

  final quizSettingsController = Get.find<QuizSettingsController>();
  final filesController = Get.find<FilesController>();

  @override
  void initState() {
    super.initState();   
    _totalTime = quizSettingsController.minute.value * 60 + quizSettingsController.seconds.value; // use minutes and seconds
    _timeLeft = _totalTime;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeLeft > 0) {
          _timeLeft--;
        } else {
          _timer.cancel();
          _saveScores();
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

    Future<void> _saveScores() async {
    try {
      // Save the current score
      scores.add(score);
      
      // Save the score in the AskMeScores table
      for (int scoreValue in scores) {
        AskMeScores newScore = AskMeScores(
          score: scoreValue,
          filesId: widget.id!, // Use the ID of the associated file
        );
        await filesController.addScores(newScore);
      }   
      //loading both the files and the scores to get the latest changes
      await filesController.loadFiles();
      // Load the scores associated with the current file ID (widget.id)
      final fileScores = filesController.scores
        .where((score) => score.filesId == widget.id)
        .map((e) => e.score)
        .toList();
      // Calculating the average score for the file
      int totalScores = fileScores.reduce((a, b) => a + b);
      int avgScore = totalScores ~/ fileScores.length;

      // Update the average score in the AskMeFiles table
      AskMeFiles updatedFile = AskMeFiles(
        id: widget.id!,
        title: widget.title, 
        filePath: widget.filePath, 
        avgScore: avgScore,
      );
      await filesController.updateFile(updatedFile);
      
      // Optionally, handle success (e.g., show a message)
    } catch (e) {
      // Optionally, handle errors (e.g., show an error message)
      debugPrint('Error saving scores: $e');
    }
  }

  void _submitAnswer() {
    if (selectedOptionIndex == null) return;
    setState(() {
      isAnswered = true;
      correctAnswer = widget.multipleChoiceQuiz?.questions[currentIndex].correctAnswer ?? widget.trueFalseQuiz?.questions[currentIndex].answer;
      if (widget.multipleChoiceQuiz != null) {
        if (widget.multipleChoiceQuiz!.questions[currentIndex].choices[selectedOptionIndex!] == correctAnswer) {
          score++;
        }
      } else if (widget.trueFalseQuiz != null) {
        if (widget.trueFalseQuiz!.questions[currentIndex].choices[selectedOptionIndex!] == correctAnswer) {
          score++;
        }
      }
      isNextButton = true;
    });
  }

   void _nextQuestion() {
    setState(() {
      if (currentIndex < (widget.multipleChoiceQuiz?.questions.length ?? widget.trueFalseQuiz?.questions.length ?? 0) - 1) {
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
    final questions = widget.multipleChoiceQuiz?.questions ?? 
                      widget.trueFalseQuiz?.questions ?? [];

    if (currentIndex >= questions.length) {
      return ScoreSection(score: score,);
    }
    final currentQuestion = questions[currentIndex];
     // Check the type of the current question and cast accordingly
    final isMultipleChoice = widget.multipleChoiceQuiz != null;
    final isTrueFalse = widget.trueFalseQuiz != null;

    final questionText = isMultipleChoice
      ? (currentQuestion as MultipleChoiceQuestion).question
      : (widget.trueFalseQuiz != null)
          ? (currentQuestion as TrueFalseQuestion).question
          : '';

    final choices = isMultipleChoice
      ? (currentQuestion as MultipleChoiceQuestion).choices
      : isTrueFalse
          ? (currentQuestion as TrueFalseQuestion).choices
          : [];

    final correctAnswer = isMultipleChoice
      ? (currentQuestion as MultipleChoiceQuestion).correctAnswer
      : (widget.trueFalseQuiz != null)
          ? (currentQuestion as TrueFalseQuestion).answer
          : '';
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
                        "${currentIndex + 1} of ${questions.length}",
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
                    value: progressvalue / questions.length,
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
                        questionText,
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      ...List.generate(choices.length, (index) {
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
                                    choices[index],
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                                if (isAnswered)
                                  Icon(
                                    choices[index] == correctAnswer
                                        ? Icons.check
                                        : Icons.close,
                                    color: choices[index] == correctAnswer
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
                        ? (currentIndex == questions.length - 1 ? () {
                            setState(() {
                              isNextButton = false; 
                              _saveScores();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => ScoreSection(score: score)),
                              );
                            });
                          } : _nextQuestion)
                        : _submitAnswer,
                    child: Text(
                      isNextButton
                          ? (currentIndex == questions.length - 1 ? "Score" : "Next")
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
