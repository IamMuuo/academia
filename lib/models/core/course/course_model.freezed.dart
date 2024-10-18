// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Course _$CourseFromJson(Map<String, dynamic> json) {
  return _Course.fromJson(json);
}

/// @nodoc
mixin _$Course {
  String get unit => throw _privateConstructorUsedError;
  String get section => throw _privateConstructorUsedError;
  @JsonKey(name: "day_of_the_week")
  String get dayOfWeek => throw _privateConstructorUsedError;
  String get period => throw _privateConstructorUsedError;
  String get campus => throw _privateConstructorUsedError;
  String get room => throw _privateConstructorUsedError;
  String get lecturer => throw _privateConstructorUsedError;
  @JsonKey(name: "start_time")
  DateTime? get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: "stop_time")
  DateTime? get stopTime => throw _privateConstructorUsedError;

  /// Serializes this Course to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CourseCopyWith<Course> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseCopyWith<$Res> {
  factory $CourseCopyWith(Course value, $Res Function(Course) then) =
      _$CourseCopyWithImpl<$Res, Course>;
  @useResult
  $Res call(
      {String unit,
      String section,
      @JsonKey(name: "day_of_the_week") String dayOfWeek,
      String period,
      String campus,
      String room,
      String lecturer,
      @JsonKey(name: "start_time") DateTime? startTime,
      @JsonKey(name: "stop_time") DateTime? stopTime});
}

/// @nodoc
class _$CourseCopyWithImpl<$Res, $Val extends Course>
    implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unit = null,
    Object? section = null,
    Object? dayOfWeek = null,
    Object? period = null,
    Object? campus = null,
    Object? room = null,
    Object? lecturer = null,
    Object? startTime = freezed,
    Object? stopTime = freezed,
  }) {
    return _then(_value.copyWith(
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      campus: null == campus
          ? _value.campus
          : campus // ignore: cast_nullable_to_non_nullable
              as String,
      room: null == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      lecturer: null == lecturer
          ? _value.lecturer
          : lecturer // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      stopTime: freezed == stopTime
          ? _value.stopTime
          : stopTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourseImplCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$$CourseImplCopyWith(
          _$CourseImpl value, $Res Function(_$CourseImpl) then) =
      __$$CourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String unit,
      String section,
      @JsonKey(name: "day_of_the_week") String dayOfWeek,
      String period,
      String campus,
      String room,
      String lecturer,
      @JsonKey(name: "start_time") DateTime? startTime,
      @JsonKey(name: "stop_time") DateTime? stopTime});
}

/// @nodoc
class __$$CourseImplCopyWithImpl<$Res>
    extends _$CourseCopyWithImpl<$Res, _$CourseImpl>
    implements _$$CourseImplCopyWith<$Res> {
  __$$CourseImplCopyWithImpl(
      _$CourseImpl _value, $Res Function(_$CourseImpl) _then)
      : super(_value, _then);

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unit = null,
    Object? section = null,
    Object? dayOfWeek = null,
    Object? period = null,
    Object? campus = null,
    Object? room = null,
    Object? lecturer = null,
    Object? startTime = freezed,
    Object? stopTime = freezed,
  }) {
    return _then(_$CourseImpl(
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as String,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as String,
      campus: null == campus
          ? _value.campus
          : campus // ignore: cast_nullable_to_non_nullable
              as String,
      room: null == room
          ? _value.room
          : room // ignore: cast_nullable_to_non_nullable
              as String,
      lecturer: null == lecturer
          ? _value.lecturer
          : lecturer // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      stopTime: freezed == stopTime
          ? _value.stopTime
          : stopTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseImpl implements _Course {
  const _$CourseImpl(
      {required this.unit,
      required this.section,
      @JsonKey(name: "day_of_the_week") required this.dayOfWeek,
      required this.period,
      required this.campus,
      required this.room,
      required this.lecturer,
      @JsonKey(name: "start_time") this.startTime,
      @JsonKey(name: "stop_time") this.stopTime});

  factory _$CourseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseImplFromJson(json);

  @override
  final String unit;
  @override
  final String section;
  @override
  @JsonKey(name: "day_of_the_week")
  final String dayOfWeek;
  @override
  final String period;
  @override
  final String campus;
  @override
  final String room;
  @override
  final String lecturer;
  @override
  @JsonKey(name: "start_time")
  final DateTime? startTime;
  @override
  @JsonKey(name: "stop_time")
  final DateTime? stopTime;

  @override
  String toString() {
    return 'Course(unit: $unit, section: $section, dayOfWeek: $dayOfWeek, period: $period, campus: $campus, room: $room, lecturer: $lecturer, startTime: $startTime, stopTime: $stopTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseImpl &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.section, section) || other.section == section) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.campus, campus) || other.campus == campus) &&
            (identical(other.room, room) || other.room == room) &&
            (identical(other.lecturer, lecturer) ||
                other.lecturer == lecturer) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.stopTime, stopTime) ||
                other.stopTime == stopTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, unit, section, dayOfWeek, period,
      campus, room, lecturer, startTime, stopTime);

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      __$$CourseImplCopyWithImpl<_$CourseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseImplToJson(
      this,
    );
  }
}

abstract class _Course implements Course {
  const factory _Course(
      {required final String unit,
      required final String section,
      @JsonKey(name: "day_of_the_week") required final String dayOfWeek,
      required final String period,
      required final String campus,
      required final String room,
      required final String lecturer,
      @JsonKey(name: "start_time") final DateTime? startTime,
      @JsonKey(name: "stop_time") final DateTime? stopTime}) = _$CourseImpl;

  factory _Course.fromJson(Map<String, dynamic> json) = _$CourseImpl.fromJson;

  @override
  String get unit;
  @override
  String get section;
  @override
  @JsonKey(name: "day_of_the_week")
  String get dayOfWeek;
  @override
  String get period;
  @override
  String get campus;
  @override
  String get room;
  @override
  String get lecturer;
  @override
  @JsonKey(name: "start_time")
  DateTime? get startTime;
  @override
  @JsonKey(name: "stop_time")
  DateTime? get stopTime;

  /// Create a copy of Course
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
