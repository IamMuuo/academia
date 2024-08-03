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