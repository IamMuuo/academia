import 'package:drift/drift.dart';

class Semester extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  @JsonKey("begins_at")
  DateTimeColumn get beginsAt => dateTime()();
  @JsonKey("ends_at")
  DateTimeColumn get endsAt => dateTime()();
  @JsonKey("created_at")
  DateTimeColumn get createdAt => dateTime()();
  @JsonKey("modified_at")
  DateTimeColumn get modifiedAt => dateTime()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
