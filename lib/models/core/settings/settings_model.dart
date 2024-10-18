/// Represents the settings in the application.

import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    @Default(false) bool showProfilePicture,
    @Default(false) bool showFeeStatistics,
    @Default(true) bool showBirthDay,
    @Default(false) bool showTranscript,
    @Default(false) bool showAudit,
    @Default(false) bool showExamTimetable,
    @Default(false) bool requireAppUnlock,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  factory Settings.empty() => const Settings();
}
