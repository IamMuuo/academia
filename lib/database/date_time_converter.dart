import 'package:drift/drift.dart';

// Custom TypeConverter to convert UTC/local time
class UtcConverter extends TypeConverter<DateTime, DateTime> {
  const UtcConverter();

  @override
  DateTime fromSql(DateTime fromDb) => fromDb.toLocal();

  @override
  DateTime toSql(DateTime value) => value.toUtc();
}
