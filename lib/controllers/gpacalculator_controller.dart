import 'package:academia/models/courses.dart';
import 'package:get/get.dart';

class GPACalculatorController extends GetxController {
  final RxList<Unit> _courses = <Unit>[].obs;

  List<Unit> get courseList => _courses;
  double get gpa => _calculateGPA();

  void addCourse(String name, String code, double creditHours, String grade) {
    final course =
        Unit(name: name, code: code, creditHours: creditHours, grade: grade);
    _courses.add(course);
  }

  void removeCourse(int index) {
    _courses.removeAt(index);
    _courses.refresh();
  }

  void updateCourse(
      {required int index,
      required String newName,
      required String newCode,
      required double newCreditHours,
      required String newGrade}) {
    _courses[index].name = newName;
    _courses[index].code = newCode;
    _courses[index].creditHours = newCreditHours;
    _courses[index].grade = newGrade;
    _courses.refresh();
  }

  double _calculateGPA() {
    double totalPoints = 0;
    double totalCreditHours = 0;
    for (var course in _courses) {
      totalPoints += getGradePoints(course.grade) * course.creditHours;
      totalCreditHours += course.creditHours;
    }
    print(totalPoints.toString());
    print(totalCreditHours.toString());
    return (totalPoints / totalCreditHours).toPrecision(2);
  }

  static double getGradePoints(String grade) {
    switch (grade) {
      case 'A':
        return 4.0;
      case 'A-':
        return 3.7;
      case 'B+':
        return 3.3;
      case 'B':
        return 3.0;
      case 'B-':
        return 2.7;
      case 'C+':
        return 2.3;
      case 'C':
        return 2.0;
      case 'C-':
        return 1.7;
      case 'D+':
        return 1.3;
      case 'D':
        return 1.0;
      case 'D-':
        return 0.7;
      case 'E':
        return 0.0;
      case 'F':
        return 0.0;
      default:
        return 0.0;
    }
  }

  static bool testValidGrade(var grade) {
    switch (grade) {
      case 'A':
        return true;
      case 'A-':
        return true;
      case 'B+':
        return true;
      case 'B':
        return true;
      case 'B-':
        return true;
      case 'C+':
        return true;
      case 'C':
        return true;
      case 'C-':
        return true;
      case 'D+':
        return true;
      case 'D':
        return true;
      case 'D-':
        return true;
      case 'E':
        return true;
      case 'F':
        return true;
      default:
        return false;
    }
  }
}
