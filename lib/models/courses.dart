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

