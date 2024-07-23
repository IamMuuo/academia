import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizSettingsController extends GetxController {
  var questionType = 'Multiple choice'.obs;
  var selectedTimer = 2.obs;

  void setQuestionType(String type) {
    questionType.value = type;
  }

  void setSelectedTimer(int timer) {
    selectedTimer.value = timer;
  }
}

class QuizSettings extends StatelessWidget {
  QuizSettings({super.key});

  final QuizSettingsController settingsController = Get.put(QuizSettingsController());

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
            Center(
              child: ElevatedButton(
                onPressed: () {
                  //Later
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                  backgroundColor: Colors.lightBlue[100],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  ),
                  child: const Text(
                    'Start a quiz',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
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
