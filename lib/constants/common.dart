// const String urlPrefix = "https://daystar-backend-atrocious-jpg.vercel.app";
// For local development

import 'package:academia/models/user.dart';
import 'package:academia/pages/attendance_page.dart';
import 'package:academia/pages/exams_timetable_page.dart';
import 'package:academia/pages/gpacalculator_page.dart';
import 'package:academia/pages/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:magnet/magnet.dart';

const String urlPrefix = "https://daystar-backend.onrender.com";
const String dbName = "appDB";
User user = User();
late Box appDB;
late Magnet magnet;

extension StringExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String title() {
    return replaceAll(RegExp(' +'), ' ')
        .split(' ')
        .map((str) => str.toCapitalized())
        .join(' ');

    // return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

const TextStyle normal = TextStyle(); // Default font

const TextStyle h1 = TextStyle(
  fontFamily: "nunito",
  fontWeight: FontWeight.bold,
  fontSize: 45,
);

const TextStyle h2 = TextStyle(
  fontFamily: "nunito",
  fontWeight: FontWeight.bold,
  fontSize: 35,
);

const TextStyle h3 = TextStyle(
  fontFamily: "nunito",
  fontWeight: FontWeight.bold,
  fontSize: 30,
);

const TextStyle h4 = TextStyle(
  fontFamily: "nunito",
  fontWeight: FontWeight.bold,
  fontSize: 25,
);

const TextStyle h5 = TextStyle(
  fontFamily: "nunito",
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

const TextStyle h6 = TextStyle(
  fontFamily: "nunito",
  fontWeight: FontWeight.bold,
  fontSize: 15,
);

final List<Map<String, dynamic>> allTools = [
  {
    "id": 1,
    "name": "Generate Catering Token",
    "action": "Generate Token",
    "image": "assets/images/food.png",
    "ontap": () async {
      try {
        var token = await magnet.fetchCateringToken();
        await Get.defaultDialog(
          title: "Your Token",
          content: Text("Your Token is ${token['message'] ?? ''}"),
        );
      } catch (e) {
        Get.snackbar(
          "Error",
          "Please check your internet connection and try again!",
          icon: const Icon(Icons.network_check),
          backgroundColor: Colors.white,
        );
      } },
    "description": "Hungry? Maybe its time to generate your catering token!"
  },
  {
    "id": 2,
    "name": "GPA Calculator",
    "action": "Calculate GPA",
    "image": "assets/images/calculator.png",
    "ontap": () {
      Get.to(GpaCalculator());
    },
    "description": "Wanna calculate your GPA? try it here"
  },
  {
    "id": 3,
    "name": "Elearning",
    "image": "assets/images/grade.png",
    "action": "Visit Elearning",
    "ontap": () {
      Get.to(const WebviewPage(
          title: "Elearning", url: "https://elearning.daystar.ac.ke"));
    },
    "description":
        "Psst! Elearning is here for you. Keep track of your assignments and notes!",
  },
  {
    "id": 4,
    "name": "Class Attendance",
    "action": "View class Attendance",
    "image": "assets/images/girl_sitted.png",
    "ontap": () {
      Get.to(const AttendancePage());
    },
    "description":
        "Curious to know how many classes you have missed this semester, this might be the tool",
  },
  {
    "id": 5,
    "name": "Exam Timetable",
    "action": "Show exam timetable",
    "image": "assets/images/exam_timetable.png",
    "ontap": () {
      Get.to(const ExamTimeTablePage());
    },
    "description":
        "Exams around the corner? Don't panic we've got you covered with the timetable",
  },
];
