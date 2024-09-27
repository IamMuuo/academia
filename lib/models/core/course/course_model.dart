import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_model.freezed.dart';
part 'course_model.g.dart';

@freezed
class Course with _$Course {
  const factory Course({
    required String unit,
    required String section,
    @JsonKey(name: "day_of_the_week") required String dayOfWeek,
    required String period,
    required String campus,
    required String room,
    required String lecturer,
    @JsonKey(name: "start_time") DateTime? startTime,
    @JsonKey(name: "stop_time") DateTime? stopTime,
  }) = _Course;

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}
