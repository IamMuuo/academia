import 'dart:io';

import 'package:academia/features/courses/models/course.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/todo/models/todo.dart';
import 'package:academia/core/core.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:logger/logger.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // Determine the correct location for the database based on the platform
    final dbFolder = await _getDatabaseDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Check for Android workaround (only if on Android)
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Handle temporary directory setup for all platforms.
    final cacheBase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cacheBase;

    return NativeDatabase(file);
  });
}

Future<Directory> _getDatabaseDirectory() async {
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    // On desktop, store the database in the home directory
    final homeDir = Directory.systemTemp;
    return homeDir;
  } else {
    // On mobile platforms, use application documents directory
    return await getApplicationDocumentsDirectory();
  }
}

@DriftDatabase(tables: [
  AttendanceModel,
  User,
  UserProfile,
  UserCredential,
  Course,
  Todo,
  ExamModel,
])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a schemaVersion getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/getting-started/#open
  AppDatabase() : super(_openConnection());

  final Logger _logger = Logger();

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (Migrator m) async {
      await m.createAll();
    }, onUpgrade: (Migrator m, int from, int to) async {
      _logger.i("Migrating from version $from to version $to");
      if (to > from) {
        m.createAll();
        _logger.i("Migrated from version $from to version $to");
      }
    }, beforeOpen: (details) async {
      _logger.i(
        "Openning cache db version ${details.versionNow} initial version ${details.versionBefore}",
      );
    });
  }

  static QueryExecutor _openConnection() {
    // driftDatabase from package:drift_flutter stores the database in
    // getApplicationDocumentsDirectory().
    driftRuntimeOptions.defaultSerializer =
        const ValueSerializer.defaults(serializeDateTimeValuesAsString: true);
    return driftDatabase(name: 'academia');
  }
}
