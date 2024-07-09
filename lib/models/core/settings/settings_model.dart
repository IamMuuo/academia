/// Represents the settings in the application.
class Settings {
  bool showProfilePicture = false;
  bool showFeeStatistics = false;
  String passcode = "";

  Settings.empty() : showProfilePicture = false;

  Settings({
    required this.showProfilePicture,
    required this.showFeeStatistics,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      showProfilePicture: json['showProfilePicture'] ?? false,
      showFeeStatistics: json['showFeeStatistics'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'showProfilePicture': showProfilePicture,
      'showFeeStatistics': showFeeStatistics,
    };
  }
}
