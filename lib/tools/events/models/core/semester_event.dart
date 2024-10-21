import 'package:intl/intl.dart';

class SemesterEvent {
  String id;
  String name;
  DateTime startDate;
  DateTime endDate;
  String semester;

  SemesterEvent({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.semester,
  });

  factory SemesterEvent.fromJson(Map<String, dynamic> json) {
    return SemesterEvent(
      id: json['id'],
      name: json['name'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      semester: json['semester'],
    );
  }

  Map<String, dynamic> toJson() {
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    return {
      'id': id,
      'name': name,
      'start_date': formatter.format(startDate),
      'end_date': formatter.format(endDate),
      'semester': semester,
    };
  }
}
