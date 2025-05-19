import 'package:drift/drift.dart';

class AttendanceModel extends Table {
  @JsonKey("student_id")
  TextColumn get studentID => text()();
  @JsonKey("date")
  DateTimeColumn get date => dateTime().withDefault(Constant(DateTime.now()))();
  @JsonKey("check_in")
  TextColumn get checkIn => text().withDefault(Constant("present"))();
  @JsonKey("campus")
  TextColumn get campus => text().withDefault(Constant("athi river"))();

}
