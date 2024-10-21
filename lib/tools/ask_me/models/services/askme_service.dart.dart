import 'package:academia/exports/barrel.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../models.dart';

class AskMeService {
  static const String askMeUrlPrefix = "http://62.169.16.219:83";

  final UserController userController = Get.find<UserController>();

  Future<Either<String, dynamic>> fetchQuestions(
    String? userId,
    String title,
    String filePath,
    bool multipleChoice,
  ) async {
    debugPrint("User Id: $userId");
    try {
      // Preparing the request using multipart/form-data
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${AskMeService.askMeUrlPrefix}/api/upload/"),
      );

      // Adding fields to the request
      request.fields['user_id'] = userId!;
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
          return right(MultipleChoiceQuiz.fromJson(jsonData));
        } else {
          return right(TrueFalseQuiz.fromJson(jsonData));
          }
        }
      else {
        var responseData = await http.Response.fromStream(response);
        debugPrint("Error: ${responseData.body}");

        return left('Failed to fetch questions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      return left('Error fetching questions: $e');
    }
  }
}

