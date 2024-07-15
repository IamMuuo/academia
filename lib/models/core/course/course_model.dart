/// The course model represents a course just as its name implies
class Course {
  final String unit;
  final String section;
  final String dayOfWeek;
  final String period;
  final String campus;
  final String room;
  final String lecturer;

  Course({
    required this.unit,
    required this.section,
    required this.dayOfWeek,
    required this.period,
    required this.campus,
    required this.room,
    required this.lecturer,
  });

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
    );
  }
}
