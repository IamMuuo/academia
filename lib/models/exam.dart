import 'package:hive/hive.dart';

part 'exam.g.dart'; // This file will be generated by the build_runner

@HiveType(typeId: 4)
class Exam {
  @HiveField(0)
  String courseCode;

  @HiveField(1)
  String day;

  @HiveField(2)
  String time;

  @HiveField(3)
  String venue;

  @HiveField(4)
  String hrs;

  @HiveField(5)
  String? invigilator;

  @HiveField(6)
  String? coordinator;

  @HiveField(7)
  String? campus;

  Exam({
    required this.courseCode,
    required this.day,
    required this.time,
    required this.venue,
    required this.hrs,
    this.invigilator,
    this.coordinator,
    this.campus,
  });

  // Factory constructor to create an Exam object from a Map
  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      courseCode: json['course_code'],
      day: json['day'],
      time: json['time'],
      venue: json['venue'],
      hrs: json['hrs'],
      invigilator: json['invigilator'],
      coordinator: json['coordinator'],
      campus: json['campus'],
    );
  }

  // Method to convert an Exam object into a Map
  Map<String, dynamic> toJson() {
    return {
      'course_code': courseCode,
      'day': day,
      'time': time,
      'venue': venue,
      'hrs': hrs,
    };
  }
}
