import 'package:academia/database/database.dart';

/// The base course state
/// note that the [busy] flag will be inherited by all
/// states to indicate that the state is busy and might
/// change
abstract class CourseState {
  CourseState({this.busy = false});
  bool busy;
}

/// The [CourseStateInitial] represents the first state
/// of courses
final class CourseStateInitial extends CourseState {}

/// The [CourseStateLoading] indicates that the courses
/// are loading either from remote or cache and they're
/// bound to change
final class CourseStateLoading extends CourseState {}

/// [CourseStateLoaded] indicates that the courses are loaded
/// The [courses] member contains a list of all courses
final class CourseStateLoaded extends CourseState {
  final List<CourseData> courses;
  CourseStateLoaded({required this.courses});
}

/// The [CourseStateError] represents the courses error state
/// It should be emitted if for example fetching was an error
/// or parsing the course data was an error
///
/// The [error] member contains a [String] message of
/// what went wrong
final class CourseStateError extends CourseState {
  final String error;
  CourseStateError({required this.error});
}
