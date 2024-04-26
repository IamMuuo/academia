import 'package:academia/exports/barrel.dart';

/// Storage Service
/// A service that handles caching mechanism on screen
/// Author: Erick M Muuo

/// Storage service
///
/// A singleton class that does the actual local storage of
/// data
class StorageService {
  static final StorageService _storageService = StorageService._internal();
  static const String dbName = "academia";
  late Box appDB;

  StorageService._internal();

  factory StorageService() {
    return _storageService;
  }

  /// Init
  /// Initializes the storage mechanism
  /// Call it once
  Future<void> init() async {
    await Hive.initFlutter();
    debugPrint("Hive initialized and ready!");
    appDB = await Hive.openBox(dbName);

    if (appDB.isOpen) {
      debugPrint("[+] Local storage database open!");
    } else {
      debugPrint("[-] Local storage database failed to open!");
    }
  }

  /// registerAdapter
  /// Attempts to register [adapters] with hive
  /// Use the [override] to ovveride by default its set to false since its expensive
  /// to re-register an adapter
  /// The [internal] parameters should only be used to register internal types but
  /// commonly leave it as it is
  /// The method throws an exeption incase an error occurs while registering the types
  void registerAdapters<T>(TypeAdapter<T> adapter,
      {bool override = false, bool internal = false}) {
    try {
      Hive.registerAdapter(adapter);
      debugPrint(
          "[Storage service]: Adapter for ${T.toString()} registered successfully");
    } catch (e) {
      debugPrint(
          "[Storage service]: Exception ${e.toString()} occurred while registering adapter");
      rethrow;
    }
  }
}
