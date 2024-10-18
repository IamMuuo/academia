// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_topic.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CourseTopic _$CourseTopicFromJson(Map<String, dynamic> json) {
  return _CourseTopic.fromJson(json);
}

/// @nodoc
mixin _$CourseTopic {
  String get course => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this CourseTopic to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CourseTopic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseTopicCopyWith<CourseTopic> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseTopicCopyWith<$Res> {
  factory $CourseTopicCopyWith(
          CourseTopic value, $Res Function(CourseTopic) then) =
      _$CourseTopicCopyWithImpl<$Res, CourseTopic>;
  @useResult
  $Res call({String course, String name, String description});
}

/// @nodoc
class _$CourseTopicCopyWithImpl<$Res, $Val extends CourseTopic>
    implements $CourseTopicCopyWith<$Res> {
  _$CourseTopicCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CourseTopic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? course = null,
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      course: null == course
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourseTopicImplCopyWith<$Res>
    implements $CourseTopicCopyWith<$Res> {
  factory _$$CourseTopicImplCopyWith(
          _$CourseTopicImpl value, $Res Function(_$CourseTopicImpl) then) =
      __$$CourseTopicImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String course, String name, String description});
}

/// @nodoc
class __$$CourseTopicImplCopyWithImpl<$Res>
    extends _$CourseTopicCopyWithImpl<$Res, _$CourseTopicImpl>
    implements _$$CourseTopicImplCopyWith<$Res> {
  __$$CourseTopicImplCopyWithImpl(
      _$CourseTopicImpl _value, $Res Function(_$CourseTopicImpl) _then)
      : super(_value, _then);

  /// Create a copy of CourseTopic
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? course = null,
    Object? name = null,
    Object? description = null,
  }) {
    return _then(_$CourseTopicImpl(
      course: null == course
          ? _value.course
          : course // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseTopicImpl implements _CourseTopic {
  const _$CourseTopicImpl(
      {required this.course, required this.name, required this.description});

  factory _$CourseTopicImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseTopicImplFromJson(json);

  @override
  final String course;
  @override
  final String name;
  @override
  final String description;

  @override
  String toString() {
    return 'CourseTopic(course: $course, name: $name, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseTopicImpl &&
            (identical(other.course, course) || other.course == course) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, course, name, description);

  /// Create a copy of CourseTopic
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseTopicImplCopyWith<_$CourseTopicImpl> get copyWith =>
      __$$CourseTopicImplCopyWithImpl<_$CourseTopicImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseTopicImplToJson(
      this,
    );
  }
}

abstract class _CourseTopic implements CourseTopic {
  const factory _CourseTopic(
      {required final String course,
      required final String name,
      required final String description}) = _$CourseTopicImpl;

  factory _CourseTopic.fromJson(Map<String, dynamic> json) =
      _$CourseTopicImpl.fromJson;

  @override
  String get course;
  @override
  String get name;
  @override
  String get description;

  /// Create a copy of CourseTopic
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseTopicImplCopyWith<_$CourseTopicImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
