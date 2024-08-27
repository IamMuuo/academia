import 'dart:convert';
import 'package:academia/controllers/user_controller.dart';
import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/ask_me/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../models.dart';

class AskMeService {
  static const String askMeUrlPrefix = "http://62.169.16.219:83";

  final UserController userController = Get.find<UserController>();
  final FilesController filesController = Get.find<FilesController>();
  final QuizSettingsController quizSettingsController = Get.find<QuizSettingsController>();

  Future<dynamic> fetchQuestions({
    required String title,
    required String filePath,
    required bool multipleChoice,
  }) async {
    const userId = 'mdD5';

    try {
      // Preparing the request using multipart/form-data
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${AskMeService.askMeUrlPrefix}/api/upload/"),
      );

      // Adding fields to the request
      request.fields['user_id'] = userId;
      request.fields['title'] = title;
      request.fields['multi_choice'] = multipleChoice.toString();

      // Attach the file
      File file = File(filePath);
      request.files.add(
        await http.MultipartFile.fromPath(
          'pdf_file', 
          file.path,
          filename: basename(file.path),
        ),
      );

      // Send the request
      var response = await request.send();

      // Handle the response
      if (response.statusCode == 201) {
        debugPrint("${response.statusCode}: Request Successful");
        var responseData = await http.Response.fromStream(response);
        var jsonData = jsonDecode(responseData.body);

        // Log the received JSON response for debugging
        debugPrint("Response JSON: $jsonData");

        if (multipleChoice) {
          if (jsonData.containsKey('questions') && jsonData['questions'] is List && jsonData['questions'].first.containsKey('multiple_choice')) {
            return MultipleChoiceQuiz.fromJson(jsonData);
          } else {
            // Log the unexpected response structure
            debugPrint('Mismatch in response: Expected MultipleChoiceQuiz but got TrueFalse data');
            // Handle the response as TrueFalseQuiz to avoid the error
            return TrueFalseQuiz.fromJson(jsonData);
          }
        } else {
          if (jsonData.containsKey('questions') && jsonData['questions'] is List) {
            return TrueFalseQuiz.fromJson(jsonData);
          } else {
            // Log the unexpected response structure
            debugPrint('Mismatch in response: Expected TrueFalseQuiz but got something else');
            throw Exception('Mismatch in response: Expected TrueFalseQuiz but got something else');
          }
        }
      } else {
        var responseData = await http.Response.fromStream(response);
        debugPrint("Error: ${responseData.body}");

        throw Exception('Failed to fetch questions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }
}

// {True or False: Lust is not a gender-specific issue, and it is not a problem that getting married will solve.: True}
