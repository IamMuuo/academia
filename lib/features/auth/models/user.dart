import 'package:drift/drift.dart';

class User extends Table {
  TextColumn get id => text()();
  TextColumn get username => text().withLength(min: 1, max: 50)();
  TextColumn get firstname => text().withLength(min: 1, max: 100)();
  TextColumn get othernames => text().nullable().withLength(min: 1, max: 100)();
  TextColumn get phone => text().withLength(min: 10, max: 15)();
  TextColumn get email => text().nullable().withLength(min: 5, max: 100)();
  TextColumn get gender => text().withLength(min: 1, max: 10)();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  @JsonKey("created_at")
  DateTimeColumn get createdAt => dateTime()();
  @JsonKey("modified_at")
  DateTimeColumn get modifiedAt => dateTime()();
  @JsonKey("national_id")
  TextColumn get nationalId => text().withLength(min: 1, max: 20)();

  @override
  Set<Column> get primaryKey => {id};
}
