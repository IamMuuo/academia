import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

class User extends Table {
  TextColumn get id => text().nullable()();
  TextColumn get username => text()();
  TextColumn get firstname => text()();
  TextColumn get othernames => text()();
  TextColumn get phone => text()();
  TextColumn get email => text()();
  TextColumn get gender => text()();
  TextColumn get nationalId => text().named('national_id')();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get createdAt => dateTime().named('created_at').nullable()();
  DateTimeColumn get modifiedAt => dateTime().named('modified_at')();
  DateTimeColumn get dateOfBirth => dateTime().named('date_of_birth')();

  // Primary key
  @override
  Set<Column> get primaryKey => {id};
}
