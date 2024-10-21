import 'package:get/get.dart';
class QuizSettingsController extends GetxController {
  var fileTitle = ''.obs;
  var filePath = ''.obs;
  var questionType = 'Multiple choice'.obs;
  var multipleChoice = true.obs;
  var minute = 2.obs;
  var seconds = 30.obs;

  void setQuestionType(String type, bool choice) {
    questionType.value = type;
    multipleChoice.value = choice;
  }

  void setFileTitle(String title) {
    fileTitle.value = title;
  }
  void setFilePath(String path) {
    filePath.value = path;
  }

  void setTimer(int min, sec) {
    minute.value = min;
    seconds.value = sec;
  }
}