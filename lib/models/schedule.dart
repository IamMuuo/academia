import 'package:hive/hive.dart';

part 'schedule.g.dart';

@HiveType(typeId: 0)
class Schedule {
  @HiveField(0)
  String? taskName;

  @HiveField(1)
  String? taskDescription;

  @HiveField(2)
  String? taskDate;

  @HiveField(3)
  String? taskTime;

  Schedule(); // silence compiler

  Schedule.fromJson(Map<dynamic, dynamic> json)
      : taskName = json["taskName"],
        taskDescription = json["taskDescription"],
        taskDate = json["taskDate"],
        taskTime = json["taskTime"];

  Map<String, String?> toJson() {
    return {
      "taskName": taskName,
      "taskDescription": taskDescription,
      "taskDate": taskDate,
      "taskTime": taskTime,
    };
  }
}
