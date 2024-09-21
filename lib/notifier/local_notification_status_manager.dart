import 'package:shared_preferences/shared_preferences.dart';

class LocalNotificationStatusManager {
  static final LocalNotificationStatusManager _instance =
      LocalNotificationStatusManager._internal();

  factory LocalNotificationStatusManager() {
    return _instance;
  }

  /// Private named constructor that prevents external instantiation.
  LocalNotificationStatusManager._internal();

  // Maps to hold notification status and counters
  final Map<int, bool> _notificationStatus = {};
  int _notificationIdCounter = 1; // Start from 1 and increment indefinitely

  /// Initializes the notification status manager.
  ///
  /// This method should be called during the app's startup to load
  /// the notification ID counter and any existing notification statuses
  /// from shared preferences.
  ///
  /// Example:
  /// ```dart
  /// await LocalNotificationStatusManager().initialize();
  /// ```
  Future<void> initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _notificationIdCounter = prefs.getInt('notificationIdCounter') ?? 1;

    await loadNotificationStatuses();
  }

  /// Saves the current notification ID counter to shared preferences.
  Future<void> saveCounters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('notificationIdCounter', _notificationIdCounter);
  }

  /// Gets the next available notification ID.
  ///
  /// This method increments the notification ID counter, saves it,
  /// and returns the new ID, which can be used to create a new notification.
  ///
  /// Returns:
  /// - `int`: The next notification ID.
  int getNextId() {
    int newId = _notificationIdCounter++;
    saveCounters(); // Save immediately after generating the ID
    return newId;
  }

  /// Updates the shown status of a notification.
  ///
  /// Parameters:
  /// - `int id`: The ID of the notification to update.
  /// - `bool isShown`: The new shown status of the notification.
  void setNotificationShown(int id, bool isShown) {
    _notificationStatus[id] = isShown;
  }

  /// Checks if a notification has been shown.
  ///
  /// Parameters:
  /// - `int id`: The ID of the notification to check.
  ///
  /// Returns:
  /// - `bool`: True if the notification has been shown, false otherwise.
  bool isNotificationShown(int id) {
    return _notificationStatus[id] ?? false;
  }

  /// Resets the shown status of a notification.
  ///
  /// Parameters:
  /// - `int id`: The ID of the notification to reset.
  void resetNotificationStatus(int id) {
    _notificationStatus[id] = false;
  }

  /// Loads stored notification statuses from shared preferences.
  ///
  /// This method populates the `_notificationStatus` map with
  /// previously stored statuses.
  Future<void> loadNotificationStatuses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 1; i < _notificationIdCounter; i++) {
      _notificationStatus[i] = prefs.getBool('notification_$i') ?? false;
    }
  }

  /// Saves notification statuses to shared preferences.
  ///
  /// This method persists the current notification statuses in
  /// shared preferences for future retrieval.
  Future<void> saveNotificationStatuses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _notificationStatus.forEach((key, value) {
      prefs.setBool('notification_$key', value);
    });
  }
}
