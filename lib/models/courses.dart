import 'dart:convert';

import 'package:academia/constants/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import 'package:http/http.dart';

part 'courses.g.dart';

@HiveType(typeId: 2)
class Courses {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? venue;

  @HiveField(2)
  String? section;

  @HiveField(3)
  String? time;

  @HiveField(4)
  String? dayOfTheWeek;

  @HiveField(5)
  String? period;

  @HiveField(6)
  String? room;

  @HiveField(7)
  String? lecturer;

  // Constructor for the Courses class
  Courses({
    this.name,
    this.venue,
    this.section,
    this.time,
    this.dayOfTheWeek,
    this.period,
    this.room,
    this.lecturer,
  });

  // Factory constructor to create a Courses object from a JSON string
  factory Courses.fromJson(Map json) {
    return Courses(
      name: json['Unit'],
      venue: json['Venue'],
      section: json['Section'],
      time: json['time'],
      dayOfTheWeek: json['Day of Week'],
      period: json['Period'],
      room: json['Lecture Room'],
      lecturer: json['Lecturer'],
    );
  }

  Map toJson() {
    return {
      'Unit': name,
      'Venue': venue,
      'Section': section,
      'time': time,
      'Day of Week': dayOfTheWeek,
      'Period': period,
      'Lecture Room': room,
      'Lecturer': lecturer,
    };
  }
}

Future<List<Courses>> fetchMyUnits() async {
  final url = Uri.parse("$urlPrefix/api/units/");

  try {
    // login
    // var user = User.fromJson(appDB.get("user"));
    // user.login();
    final response = await get(
      url,
    );

    debugPrint(response.body);

    if (response.statusCode == 200) {
      debugPrint(response.body);
      var body = json.decode(response.body);
      List unitsList = body[0];
      List<Courses> myUnits = <Courses>[];
      for (int i = 1; i < unitsList.length; i++) {
        myUnits.add(Courses.fromJson(unitsList[i]));
      }

      return myUnits;
    }
  } catch (e) {
    debugPrint(e.toString());
  }

  return [];
}
