import 'package:hive/hive.dart';

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
}
