class Exam {
  String courseCode;
  String day;
  String time;
  String venue;
  String hrs;
  String? invigilator;
  String? coordinator;
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

  // Convert an Exam into a Map.
  Map<String, dynamic> toMap() {
    return {
      'course_code': courseCode,
      'day': day,
      'time': time,
      'venue': venue,
      'hrs': hrs,
      'invigilator': invigilator,
      'coordinator': coordinator,
      'campus': campus,
    };
  }

  // Create an Exam from a Map.
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
}
