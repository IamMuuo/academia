class Semester {
  String id;
  DateTime dateAdded;
  String name;
  String code;
  DateTime startDate;
  DateTime endDate;

  Semester({
    required this.id,
    required this.dateAdded,
    required this.name,
    required this.code,
    required this.startDate,
    required this.endDate,
  });

  factory Semester.fromJson(Map<String, dynamic> json) {
    return Semester(
      id: json['id'],
      dateAdded: DateTime.parse(json['date_added']),
      name: json['name'],
      code: json['code'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date_added': dateAdded.toIso8601String(),
      'name': name,
      'code': code,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
    };
  }
}
