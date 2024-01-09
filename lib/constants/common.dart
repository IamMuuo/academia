// const String urlPrefix = "https://daystar-backend-atrocious-jpg.vercel.app";
// For local development

import 'package:academia/models/user.dart';
import 'package:flutter/material.dart';
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

Map<String, int> notifications = {
  "user": 1,
  "course": 2,
  "course_begins": 3,
  "course_ends": 4,
  "tips": 5,
  "greetings": 6,
  "exam_done": 7,
  "exam_upcoming": 8,
  "exam_in_progress": 9,
  "fee_balance": 10,
  "semester_timeLine": 11,
};

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
