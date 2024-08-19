import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quizSettings_controller.dart';
import '../pages/pages.dart';
import 'widgets.dart';

class ModalContent extends StatelessWidget {  
  ModalContent({super.key});

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
    TextEditingController titleController = TextEditingController();
    final QuizSettingsController timerController = Get.put(QuizSettingsController());
    final TextEditingController minuteController = TextEditingController();
    final TextEditingController secondsController = TextEditingController();

     //Update controllers with current values from QuizSettingsController
    void updateControllers() {
      minuteController.text = timerController.minute.value.toString();
      secondsController.text = timerController.seconds.value.toString();
    }

    // Update controllers when the widget is built
    updateControllers();

    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: titleController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value?.length == null) {
                  return "Please enter a title";
                }
                return null;
                },
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: "Please Enter Title for your Document",
                label: const Text("Title"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 10,),
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
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Set a timer",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    // //Obx(() => TimeInputField(label: "Seconds",  controller: minuteController)),
                    // TimeInputField(label: "Seconds",  controller: minuteController),
                    // //TimeInputField(label: "Minute", initialValue: 2),
                    // const Text(" : ", style: TextStyle(fontSize: 20)),
                    // //Obx(() => TimeInputField(label: "Seconds", controller: secondsController)),
                    // TimeInputField(label: "Seconds", controller: secondsController)
                    // //TimeInputField(label: "Seconds", initialValue: 30),
                      Obx(() {
                      // Update the controller values whenever the observed values change
                      updateControllers();
                      return TimeInputField(
                        label: "Minutes",
                        controller: minuteController,
                        onChanged: (value) {
                          timerController.minute.value = int.tryParse(value)!;
                        },
                      );
                    }),
                    const Text(" : ", style: TextStyle(fontSize: 20)),
                    Obx(() {
                      // Update the controller values whenever the observed values change
                      updateControllers();
                      return TimeInputField(
                        label: "Seconds",
                        controller: secondsController,
                        onChanged: (value) {
                          timerController.seconds.value = int.tryParse(value)!;
                        },
                      );
                    }),
                  ]
                ),
              ],
            ),
            const SizedBox(height: 20.0,),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    //padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                    backgroundColor: Colors.lightBlue[100],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    int? minuteValue = int.tryParse(minuteController.text);
                    int? secondsValue = int.tryParse(secondsController.text);
      
                    // Ensure the values are not null
                    if (minuteValue != null && secondsValue != null) {
                      timerController.setTimer(minuteValue, secondsValue);
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => QuestionScreen(questions: questions,))
                      );
                    } else {
                      // Handle invalid input case
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter valid numbers")),
                      );
                    }
                  }, 
                  child: const Text("Generate"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}