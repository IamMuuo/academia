import 'package:hive/hive.dart';

part 'tasks.g.dart';

@HiveType(typeId: 3)
class Task {
  @HiveField(0)
  DateTime? deadline;

  @HiveField(1)
  String? unit;

  @HiveField(2)
  String? type;

  @HiveField(3)
  String? title;

  @HiveField(4)
  String? description;

  @HiveField(5)
  int? progress;

  Task(
      {required this.deadline,
      required this.unit,
      required this.type,
      required this.title,
      required this.description,
      this.progress = 0});

  Task.fromJson(Map<dynamic, dynamic> json)
      : deadline = json["deadline"],
        unit = json["unit"],
        type = json["type"],
        title = json["title"],
        description = json["description"],
        progress = json["progress"] ?? 0;

  Map<String, dynamic> toJson() {
    return {
      "deadline": deadline,
      "unit": unit,
      "type": type,
      "title": title,
      "description": description,
      "progress": progress,
    };
  }
}
