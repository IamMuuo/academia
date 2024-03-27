import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class ExamsTimeTableController extends GetxController {
  var index = (-1).obs;
  late List<Map<String, dynamic>> quotes = [];

  Future<void> fetchRandomQuote() async {
    try {
      quotes = await magnet.fetchRandomQuotes();
      index.value = 0;
    } catch (e) {
      showCustomSnackbar(
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

  Future<void> fetchExams() async {
    await Future.delayed(const Duration(seconds: 10));
    return;
  }

  List<Courses> userCourses = <Courses>[];
  @override
  Future<void> onInit() async {
    await fetchRandomQuote();
    // Load user courses
    debugPrint(appDB.keys.toString());
    final List coursesData = await appDB.get("timetable");
    coursesData.forEach((element) {
      if (element != null) {
        userCourses.add(element);
      }
    });
    super.onInit();
  }
}
