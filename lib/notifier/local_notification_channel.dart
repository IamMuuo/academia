/// Enum representing different notification channels within the app.
///
/// Each channel contains a `channelKey`, `channelName`, and
/// `channelDescription` which are required for initializing
/// notification channels in the app.
enum LocalNotificationChannelType {
  reminders(
    channelKey: 'reminders',
    channelName: 'Academia Reminders',
    channelDescription: "Academia's reminder notifications",
  ),
  general(
    channelKey: 'general',
    channelName: 'Academia General Notifications',
    channelDescription: "Academia's general notifications",
  ),
  social(
    channelKey: 'social',
    channelName: 'Academia Social Notifications',
    channelDescription: "Academia's social notifications",
  );

  // Notification channel properties
  final String channelKey;
  final String channelName;
  final String channelDescription;

  // Constructor for the enum, initializing the properties
  const LocalNotificationChannelType({
    required this.channelKey,
    required this.channelName,
    required this.channelDescription,
  });
}
