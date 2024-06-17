/// Represents the settings in the application.
class Settings {
  bool showProfilePicture = false;



Settings.empty() : showProfilePicture = false;


 Settings({
    required this.showProfilePicture,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      showProfilePicture: json['showProfilePicture'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'showProfilePicture': showProfilePicture,
    };
  }
}

