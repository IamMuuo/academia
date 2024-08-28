import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../models/models.dart';

class ExamsTimeTableController extends GetxController {
  var index = (-1).obs;
  var hasExams = false.obs;
  late List<Map<String, dynamic>> quotes = [];
  List<Exam> exams = [];
  final ExamModelHelper _examDbHelper = ExamModelHelper();
  final CourseModelHelper _courseDbHelper = CourseModelHelper();

  Future<void> fetchRandomQuote() async {
    const String apiUrl = "https://zenquotes.io/api/quotes/";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Parse the JSON data
        List<dynamic> data = json.decode(response.body);

        // Convert the JSON data into a list of quotes
        quotes = data.map((quote) {
          return {
            'q': quote['q'],
            'a': quote['a'],
          };
        }).toList();

        index.value = 0;
      } else {
        throw Exception("Failed to load quotes");
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        colorText: Colors.red,
        backgroundColor: Colors.grey,
      );
    }
  }

  void nextQuote() {
    if (quotes.isNotEmpty && index.value < 49) {
      index.value++;
    } else if (index.value == 49) {
      fetchRandomQuote().then((value) => value); // Do nothing
    }
  }

  void previousQuote() {
    if (quotes.isNotEmpty && index.value > 0) {
      index.value--;
    } else if (index.value == 0) {
      fetchRandomQuote().then((value) => value); // Do nothing
    }
  }

  Future<List<Exam>> fetchExams(List<String> units) async {
    const String apiUrl = "http://academia.erick.serv00.net/timetables/exams/";

    try {
      // Prepare the request body
      final body = json.encode({'course_codes': units});

      // Send the POST request to the server
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        // Parse the JSON data
        final List<dynamic> data = json.decode(response.body);

        // Convert the JSON data into a list of Exam objects
        List<Exam> examData = data.map((e) => Exam.fromJson(e)).toList();

        // Sort the exams by date and time
        examData.sort((a, b) {
          final formatter = DateFormat('EEEE dd/MM/yy');
          final aDate = formatter.parse(a.day.title());
          final bDate = formatter.parse(b.day.title());

          // Compare the dates first
          final dateComparison = aDate.compareTo(bDate);
          if (dateComparison != 0) return dateComparison;

          // If the dates are the same, compare the times
          final aTimeRange = a.time.split('-');
          final bTimeRange = b.time.split('-');
          final aStartTime = DateFormat('h:mma').parse(aTimeRange[0]);
          final bStartTime = DateFormat('h:mma').parse(bTimeRange[0]);

          return aStartTime.compareTo(bStartTime);
        });

        return examData;
      } else {
        throw Exception(
            "Failed to load exams. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching exams: $e");
    }
  }

  Future<void> addExamToStorage(Exam exam) async {
    // Insert exam into the database using the SQLite helper
    await _examDbHelper.create(exam.toMap());

    // Fetch all exams to refresh the list
    exams = await _examDbHelper.queryAll().then(
          (data) => data.map((e) => Exam.fromJson(e)).toList(),
        );

    // Update the hasExams observable
    hasExams.value = exams.isNotEmpty;
  }

  Future<void> removeExamFromStorage(Exam exam) async {
    // Remove exam from the database using the SQLite helper
    await _examDbHelper.delete({'course_code': exam.courseCode});

    // Fetch all exams to refresh the list
    exams = await _examDbHelper.queryAll().then(
          (data) => data.map((e) => Exam.fromJson(e)).toList(),
        );

    // Update the hasExams observable
    hasExams.value = exams.isNotEmpty;
  }

  @override
  Future<void> onInit() async {
    await fetchRandomQuote();
    hasExams.value = false;

    // Check if the local database has exams
    exams = await _examDbHelper.queryAll().then(
          (data) => data.map((e) => Exam.fromJson(e)).toList(),
        );

    if (exams.isNotEmpty) {
      hasExams.value = true;
    } else {
      // Load the units
      final List<Map<String, dynamic>> courseData = await _courseDbHelper
          .queryAll(); // Assuming _courseDbHelper is your SQLite helper for courses
      List<Course> courses = courseData.map((e) => Course.fromJson(e)).toList();

      List<String> courseTitles = courses
          .map((e) => "${e.unit.replaceAll('-', '')}${e.section.split('-')[0]}")
          .toList();

      // Fetch from server and store in the database
      exams = await fetchExams(courseTitles);
      for (var exam in exams) {
        await _examDbHelper.create(exam.toMap());
      }
      hasExams.value = exams.isNotEmpty;
    }
    super.onInit();
  }
}
