// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryImpl _$$StoryImplFromJson(Map<String, dynamic> json) => _$StoryImpl(
      id: json['id'] as String,
      description: json['description'] as String,
      media: json['media'] as String?,
      fileType: json['file_type'] as String,
      numberOfViews: (json['number_of_views'] as num).toInt(),
      url: json['url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      viewed: json['viewed'] as bool? ?? false,
      organization: json['organization'] as String,
    );

Map<String, dynamic> _$$StoryImplToJson(_$StoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'media': instance.media,
      'file_type': instance.fileType,
      'number_of_views': instance.numberOfViews,
      'url': instance.url,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'viewed': instance.viewed,
      'organization': instance.organization,
    };
