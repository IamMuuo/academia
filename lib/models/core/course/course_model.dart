// /// The course model represents a course just as its name implies
// class Course {
//   final String unit;
//   final String section;
//   final String dayOfWeek;
//   final String period;
//   final String campus;
//   final String room;
//   final String lecturer;
//
//   Course({
//     required this.unit,
//     required this.section,
//     required this.dayOfWeek,
//     required this.period,
//     required this.campus,
//     required this.room,
//     required this.lecturer,
//   });
//
//   // Method to convert Course instance to a Map (JSON format)
//   Map<String, dynamic> toJson() {
//     return {
//       'unit': unit,
//       'section': section,
//       'day_of_the_week': dayOfWeek,
//       'period': period,
//       'campus': campus,
//       'room': room,
//       'lecturer': lecturer,
//     };
//   }
//
//   // Static method to create a Course instance from a Map (JSON format)
//   static Course fromJson(Map<String, dynamic> json) {
//     return Course(
//       unit: json['unit'],
//       section: json['section'],
//       dayOfWeek: json['day_of_the_week'],
//       period: json['period'],
//       campus: json['campus'],
//       room: json['room'],
//       lecturer: json['lecturer'],
//     );
//   }
// }

import 'package:intl/intl.dart';

/// The course model represents a course just as its name implies
class Course {
  final String unit;
  final String section;
  final String dayOfWeek;
  final String
      period; // This contains the time range (e.g., "02:10 PM-05:10 PM")
  final String campus;
  final String room;
  final String lecturer;
  late DateTime startTime;
  late DateTime stopTime;

  Course({
    required this.unit,
    required this.section,
    required this.dayOfWeek,
    required this.period,
    required this.campus,
    required this.room,
    required this.lecturer,
  }) {
    extractTimesFromPeriod(period);
  }

  // Method to convert Course instance to a Map (JSON format)
  Map<String, dynamic> toJson() {
    return {
      'unit': unit,
      'section': section,
      'day_of_the_week': dayOfWeek,
      'period': period,
      'campus': campus,
      'room': room,
      'lecturer': lecturer,
      'start_time': startTime.toIso8601String(),
      'stop_time': stopTime.toIso8601String(),
    };
  }

  // Static method to create a Course instance from a Map (JSON format)
  static Course fromJson(Map<String, dynamic> json) {
    return Course(
      unit: json['unit'],
      section: json['section'],
      dayOfWeek: json['day_of_the_week'],
      period: json['period'],
      campus: json['campus'],
      room: json['room'],
      lecturer: json['lecturer'],
    )..extractTimesFromPeriod(json['period']);
  }

  // Private method to extract start and stop times from the period string
  void extractTimesFromPeriod(String period) {
    // Split the period by the dash ('-')
    List<String> times = period.split('-');

    // Define a DateFormat to parse the time strings
    DateFormat formatter = DateFormat("hh:mm a");

    // Parse start and stop times
    startTime = formatter.parse(times[0].trim());
    stopTime = formatter.parse(times[1].trim());
  }
}
