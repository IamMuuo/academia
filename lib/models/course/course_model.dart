class Course {
  String? name;
  String? venue;
  String? section;
  String? time;
  String? dayOfTheWeek;
  String? period;
  String? room;
  String? lecturer;

  // Constructor for the Courses class
  Course({
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
  factory Course.fromJson(Map json) {
    return Course(
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

  factory Course.fromDB(Map<String, dynamic> json) {
    return Course(
      name: json['unit'],
      venue: json['venue'],
      section: json['section'],
      time: json['time'],
      dayOfTheWeek: json['day_of_the_week'],
      period: json['period'],
      room: json['room'],
      lecturer: json['lecturer'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unit': name,
      'venue': venue,
      'section': section,
      'time': time,
      'day_of_the_week': dayOfTheWeek,
      'period': period,
      'room': room,
      'lecturer': lecturer,
    };
  }
}
