import 'package:drift/drift.dart';

class Course extends Table {
  TextColumn get id => text().nullable()();
  TextColumn get unit => text()();
  TextColumn get section => text()();
  @JsonKey("day_of_the_week")
  TextColumn get weekDay => text()();
  TextColumn get campus => text()();
  TextColumn get room => text()();
  TextColumn get lecturer => text()();
  TextColumn get period => text()();
  IntColumn get color => integer().nullable()();
  @JsonKey("created_at")
  DateTimeColumn get createdAt =>
      dateTime().nullable().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
