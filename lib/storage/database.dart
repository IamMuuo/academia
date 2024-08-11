import 'package:academia/exports/barrel.dart';
import 'package:academia/storage/schemas.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Defines a singleton class that will handles database connection.
///
/// The database helper class is a singleton class that provides
///
/// 1. The database connection instance.
/// 2. The database name
///
/// By default the database should be stored in the application's
/// document directory

class DatabaseHelper {
  /// The database connection instace
  static Database? _database;

  /// Database name
  static const String databaseName = "academia.db";

  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  /// A getter for the database connection instance
  /// If the database connection was not established earlier,
  /// it attempts to create the database connection instance using [_initDatabase]
  /// then returns the connection instance that was established
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  /// _initDatabase is a private method that will be calle
  /// by the getter [database] if no connection was alive
  /// at the moment of calling.
  ///
  /// _initDatabase attempts to create a database connection
  /// and returns it if it was successful.
  ///
  Future<Database> _initDatabase() async {
    if (_database != null) {
      return _database!;
    }
    String path = join(
      (await getApplicationDocumentsDirectory()).path,
      databaseName,
    );

    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      final db = await databaseFactoryFfi.openDatabase(path);

      // call create manually since ffi does not call onCreate
      _create(db, 1);
      return db;
    }
    return await openDatabase(
      path,
      version: 1,
      onCreate: _create,
    );
  }

  void _create(Database db, int newVersion) async {
    schemas.forEach((key, value) async {
      await db.execute(value);
    });
  }

  /// Deletes the databse from local storage along with the data it contains
  Future<void> deleteDataBase() async {
    String path = join(
      (await getApplicationDocumentsDirectory()).path,
      databaseName,
    );

    if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      databaseFactoryFfi.deleteDatabase(path);
      return;
    }

    databaseFactory.deleteDatabase(path);
  }
}
