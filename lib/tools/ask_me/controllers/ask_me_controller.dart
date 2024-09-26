import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/ask_me/models/services/askme_service.dart.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'controllers.dart';

class AskMeController extends GetxController {
  final AskMeService _service = AskMeService();
  UserController userController = Get.find<UserController>();
  QuizSettingsController quizSettingsController =
      Get.find<QuizSettingsController>();
  // final userId = 'MQ4';
  /*
    For testing purposes as of now, I would recommend you to uncomment the above 
    while comment the userId gotten from the userController since there is an issue
    at the moment on the backend since the backend does not expect the current number 
    of characters for the user id which is 32 which is a really large number.
    This the error I am getting: 
    Error: {"user_id":["Ensure this field has no more than 12 characters."]}
    The above issue is currently being fixed though.
  */

  Future<Either<String, dynamic>> fetchQuestions() async {
    final result = await _service.fetchQuestions(
        userController.user.value?.id?.substring(0, 12),
        // userId,
        quizSettingsController.fileTitle.value,
        quizSettingsController.filePath.value,
        quizSettingsController.multipleChoice.value);

    return result.fold((l) {
      return left(l);
    }, (r) {
      return right(r);
    });
  }
}
