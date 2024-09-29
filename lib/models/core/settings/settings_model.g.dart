// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsImpl _$$SettingsImplFromJson(Map<String, dynamic> json) =>
    _$SettingsImpl(
      showProfilePicture: json['showProfilePicture'] as bool? ?? false,
      showFeeStatistics: json['showFeeStatistics'] as bool? ?? false,
      showBirthDay: json['showBirthDay'] as bool? ?? true,
      showTranscript: json['showTranscript'] as bool? ?? false,
      showAudit: json['showAudit'] as bool? ?? false,
      showExamTimetable: json['showExamTimetable'] as bool? ?? false,
      passcode: json['passcode'] as String? ?? "",
      primaryColor: json['primaryColor'] as String? ?? "##72D5E0",
    );

Map<String, dynamic> _$$SettingsImplToJson(_$SettingsImpl instance) =>
    <String, dynamic>{
      'showProfilePicture': instance.showProfilePicture,
      'showFeeStatistics': instance.showFeeStatistics,
      'showBirthDay': instance.showBirthDay,
      'showTranscript': instance.showTranscript,
      'showAudit': instance.showAudit,
      'showExamTimetable': instance.showExamTimetable,
      'passcode': instance.passcode,
      'primaryColor': instance.primaryColor,
    };
