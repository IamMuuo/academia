import 'package:academia/models/core/course/course_model.dart';
import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/gpa_calculator/models/unit.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GPACalculatorController extends GetxController {
  RxList<Course> _registeredCourses = <Course>[].obs;
  final RxList<Unit> _courses = <Unit>[].obs;

  List<Unit> get courseList => _courses;

  List<Course> get registeredCoursesList => _registeredCourses;
  double get gpa => _calculateGPA();

  set registeredCourses(List<Course> courses) {
    _registeredCourses = courses.obs;
  }

  void addCourse(String name, String creditHours, String grade) {
    double tcreditHours = 0;
    try {
      tcreditHours = double.parse(creditHours);
    } catch (e) {
      Get.defaultDialog(
          title: "Incorrect credit Hours",
          content: const Text("Credit hours must be a number"));
      throw Exception('Credit hours must be a number');
    }
    final course = Unit(name: name, creditHours: tcreditHours, grade: grade);
    _courses.add(course);
  }

  void removeCourse(int index) {
    _courses.removeAt(index);
    _courses.refresh();
  }

  void updateCourse(
      {required int index,
      required String newName,
      // required String newCode,
      required String newCreditHours,
      required String newGrade}) {
    _courses[index].name = newName;
    // _courses[index].code = newCode;
    try {
      _courses[index].creditHours = double.parse(newCreditHours);
    } catch (e) {
      Get.defaultDialog(
          title: "Incorrect credit Hours",
          content: const Text("Credit hours must be a number"));
      throw Exception('Credit hours must be a number');
    }
    _courses[index].grade = newGrade;
    _courses.refresh();
  }

  double _calculateGPA() {
    double totalPoints = 0;
    double totalCreditHours = 0;
    for (var course in _courses) {
      totalPoints += getGradePoints(course.grade) * (course.creditHours);
      totalCreditHours += course.creditHours;
    }
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
