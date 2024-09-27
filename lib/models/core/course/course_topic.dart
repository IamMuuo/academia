import 'package:freezed_annotation/freezed_annotation.dart';

part 'course_topic.freezed.dart';
part 'course_topic.g.dart';

@freezed
class CourseTopic with _$CourseTopic {
  const factory CourseTopic({
    required String course,
    required String name,
    required String description,
  }) = _CourseTopic;

  factory CourseTopic.fromJson(Map<String, dynamic> json) =>
      _$CourseTopicFromJson(json);
}
