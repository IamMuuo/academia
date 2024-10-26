import 'package:academia/tools/ask_me/controllers/quiz_settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChoiceWidget extends StatelessWidget {
  final String label;
  final bool multipleChoice;
  ChoiceWidget({super.key, required this.label, required this.multipleChoice});

  final QuizSettingsController settingsController = Get.put(QuizSettingsController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(() => ChoiceChip(
      label: Text(label), 
      selected: settingsController.questionType.value == label,
      onSelected: (bool selected) {
        settingsController.setQuestionType(label, multipleChoice);
      },
      // selectedColor: Colors.pink[100],
      // backgroundColor: Colors.grey[100],
      selectedColor: theme.colorScheme.tertiaryContainer,
      backgroundColor: theme.colorScheme.secondaryContainer,
      ));
  }
}