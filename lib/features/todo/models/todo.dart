import 'package:academia/features/auth/models/user.dart';
import 'package:academia/features/courses/models/course.dart';
import 'package:drift/drift.dart';

class Todo extends Table {
  IntColumn get id => integer().autoIncrement().nullable()();
  TextColumn get userId => text().references(User, #id)();
  TextColumn get unit => text().references(Course, #unit).nullable()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  TextColumn get subtasks => text().nullable()();
  IntColumn get color => integer().nullable()();
  BoolColumn get notify => boolean().withDefault(const Constant(false))();
  BoolColumn get complete => boolean().withDefault(const Constant(false))();
  BoolColumn get autocomplete => boolean().withDefault(const Constant(false))();
  DateTimeColumn get notifyAt => dateTime().nullable()();
  DateTimeColumn get duedate => dateTime().nullable()();
  DateTimeColumn get dateCreated =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get dateModified =>
      dateTime().withDefault(Constant(DateTime.now()))();
  DateTimeColumn get completedAt =>
      dateTime().withDefault(Constant(DateTime.now()))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
