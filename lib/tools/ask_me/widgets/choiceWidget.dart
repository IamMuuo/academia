import 'package:academia/tools/ask_me/controllers/quizSettings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoiceWidget extends StatelessWidget {
  String label;
  ChoiceWidget({super.key, required this.label});

  final QuizSettingsController settingsController = Get.put(QuizSettingsController());

  @override
  Widget build(BuildContext context) {
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
}