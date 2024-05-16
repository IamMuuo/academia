/// Represents the settings in the application.
///
/// This model includes various settings that can be enabled or disabled by the user,
/// such as showing the profile picture, enabling notifications, and more.
class SettingsModel {
  int? id;

  /// Indicates whether the profile picture should be shown.
  bool? showProfilePicture;

  /// Indicates whether notifications are enabled.
  bool? notificationsEnabled;

  /// Indicates whether the transcript feature is enabled.
  bool? enableTranscript;

  /// Indicates whether the audit feature is enabled.
  bool? enableAudit;

  /// Indicates whether the fee statistics should be shown.
  bool? showFeeStatistics;

  /// Constructor to initialize all fields of the settings model.
  ///
  /// All fields are optional and default to `null`.
  SettingsModel({
    this.id,
    this.showProfilePicture,
    this.notificationsEnabled,
    this.enableTranscript,
    this.enableAudit,
    this.showFeeStatistics,
  });

  /// Creates a [SettingsModel] object from a map.
  ///
  /// The map must contain keys corresponding to the fields
  /// of this class and values being integers (1 for true, 0 for false).
  factory SettingsModel.fromJson(Map<String, dynamic> map) {
    return SettingsModel(
      id: map['id'],
      showProfilePicture: map['show_profile_picture'] == 1,
      notificationsEnabled: map['notifications_enabled'] == 1,
      enableTranscript: map['enable_transcript'] == 1,
      enableAudit: map['enable_audit'] == 1,
      showFeeStatistics: map['show_fee_statistics'] == 1,
    );
  }

  /// Converts the settings model to a JSON string.
  ///
  /// The resulting JSON string represents a map with keys corresponding to the fields
  /// of this class and values being integers (1 for true, 0 for false).
  Map<String, dynamic> toJson() {
    return {
      'show_profile_picture': showProfilePicture == true ? 1 : 0,
      'notifications_enabled': notificationsEnabled == true ? 1 : 0,
      'enable_transcript': enableTranscript == true ? 1 : 0,
      'enable_audit': enableAudit == true ? 1 : 0,
      'show_fee_statistics': showFeeStatistics == true ? 1 : 0,
    };
  }

  /// Converts the [SettingsModel] instance to a [Map].
  ///
  /// This map is suitable for storage in SQLite, where boolean values are stored as integers
  /// (1 for true, 0 for false).
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'show_profile_picture': showProfilePicture == true ? 1 : 0,
      'notifications_enabled': notificationsEnabled == true ? 1 : 0,
      'enable_transcript': enableTranscript == true ? 1 : 0,
      'enable_audit': enableAudit == true ? 1 : 0,
      'show_fee_statistics': showFeeStatistics == true ? 1 : 0,
    };
  }

  /// Creates a [SettingsModel] object from a [Map].
  ///
  /// The map should contain keys corresponding to the fields of this class
  /// and values being integers (1 for true, 0 for false).
  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      id: map['id'],
      showProfilePicture: map['showProfilePicture'] == 1,
      notificationsEnabled: map['notificationsEnabled'] == 1,
      enableTranscript: map['enableTranscript'] == 1,
      enableAudit: map['enableAudit'] == 1,
      showFeeStatistics: map['showFeeStatistics'] == 1,
    );
  }
}
