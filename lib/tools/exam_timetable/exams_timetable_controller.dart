import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExamsTimeTableController extends GetxController {
  var index = (-1).obs;
  var hasExams = false.obs;
  late List<Map<String, dynamic>> quotes = [];
  List<Exam> exams = [];

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

  Future<List<Exam>> fetchExams(List<String> units) async {
    final examData = (await magnet.fetchExam(units))
        .map((e) => Exam.fromJson(e))
        .toList()
        .cast<Exam>();

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
  }

  Future<void> addExamToStorage(Exam exam) async {
    exams = await appDB.get("exams").toList().cast<Exam>();
    exams.add(exam);
    exams.sort((a, b) {
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

    await appDB.put("exams", exams);

    // trigger a data refersh
    hasExams.value = false;
    hasExams.value = true;
  }

  Future<void> removeExamFromStorage(Exam exam) async {
    exams = await appDB.get("exams").toList().cast<Exam>();
    exams.remove(exam);

    if (exams.isEmpty) {
      await appDB.delete("exams");
      // trigger a data refersh
      hasExams.value = false;
    } else {
      await appDB.put("exams", exams);
      // trigger a data refersh
      hasExams.value = false;
      hasExams.value = true;
    }
  }

  @override
  Future<void> onInit() async {
    await fetchRandomQuote();
    hasExams.value = false;

    // Check if the local database has exams
    if (appDB.containsKey("exams")) {
      hasExams.value = true;
      // load the exams
      exams = await appDB.get("exams").toList().cast<Exam>();
    } else {
      // load the units
      final List<Courses> courses =
          await appDB.get("timetable").toList().cast<Courses>();
      List<String> courseTitles = courses
          .map((e) =>
              "${e.name?.replaceAll('-', '')}${e.section?.split('-')[0]}")
          .toList();
      print(courseTitles);

      // fetch from server
      exams = await fetchExams(courseTitles);
      await appDB.put("exams", exams);
      hasExams.value = exams.isNotEmpty;
    }
    super.onInit();
  }
}
