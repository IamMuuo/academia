/// Represents the settings in the application.
class Settings {
  bool showProfilePicture = false;
  bool showFeeStatistics = false;
  bool showBirthDay = true;
  bool showTranscript = false;
  bool showAudit = false;
  bool showExamTimetable = false;
  String passcode = "";

  Settings.empty() : showProfilePicture = false;

  Settings({
    required this.showProfilePicture,
    required this.showFeeStatistics,
    required this.showBirthDay,
    required this.showTranscript,
    required this.showAudit,
    required this.showExamTimetable,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      showProfilePicture: json['showProfilePicture'] ?? false,
      showFeeStatistics: json['showFeeStatistics'] ?? false,
      showBirthDay: json['showBirthDay'] ?? false,
      showTranscript: json['showTranscript'] ?? false,
      showAudit: json['showAudit'] ?? false,
      showExamTimetable: json['showExamTimetable'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'showProfilePicture': showProfilePicture,
      'showFeeStatistics': showFeeStatistics,
      'showBirthDay': showBirthDay,
      'showTranscript': showTranscript,
      'showAudit': showAudit,
      'showExamTimetable': showExamTimetable,
    };
  }
}
