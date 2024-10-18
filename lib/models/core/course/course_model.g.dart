// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CourseImpl _$$CourseImplFromJson(Map<String, dynamic> json) => _$CourseImpl(
      unit: json['unit'] as String,
      section: json['section'] as String,
      dayOfWeek: json['day_of_the_week'] as String,
      period: json['period'] as String,
      campus: json['campus'] as String,
      room: json['room'] as String,
      lecturer: json['lecturer'] as String,
      startTime: json['start_time'] == null
          ? null
          : DateTime.parse(json['start_time'] as String),
      stopTime: json['stop_time'] == null
          ? null
          : DateTime.parse(json['stop_time'] as String),
    );

Map<String, dynamic> _$$CourseImplToJson(_$CourseImpl instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      'section': instance.section,
      'day_of_the_week': instance.dayOfWeek,
      'period': instance.period,
      'campus': instance.campus,
      'room': instance.room,
      'lecturer': instance.lecturer,
      'start_time': instance.startTime?.toIso8601String(),
      'stop_time': instance.stopTime?.toIso8601String(),
    };
