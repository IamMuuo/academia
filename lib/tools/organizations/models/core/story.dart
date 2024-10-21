import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.freezed.dart';
part 'story.g.dart';

@freezed
class Story with _$Story {
  const factory Story({
    required String id,
    required String description,
    String? media, // Nullable media field
    @JsonKey(name: 'file_type') required String fileType,
    @JsonKey(name: 'number_of_views') required int numberOfViews,
    String? url, // Nullable URL field
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    @JsonKey(name: 'viewed', defaultValue: false) required bool viewed,
    required String organization,
  }) = _Story;

  // Factory constructor for creating a new Story instance from a Map (JSON)
  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}
