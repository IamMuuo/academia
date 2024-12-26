import 'package:academia/features/courses/cubit/course_state.dart';
import 'package:academia/features/courses/repository/course_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCubit extends Cubit<CourseState> {
  final CourseRepository _courseRepository = CourseRepository();
  CourseCubit() : super(CourseStateInitial()) {
    fetchCachedCourses().then((value) {});
  }

  Future<void> syncCourses() async {
    final res = await _courseRepository.syncCoursesWithMagnet();
    if (res.isLeft()) {
      emit(CourseStateError(error: (res as Left).value));
    }
    emit(CourseStateLoaded(courses: (res as Right).value));
  }

  Future<void> fetchCachedCourses() async {
    final result = await _courseRepository.fetchAllCachedCourses();
    result.fold((error) {
      emit(CourseStateError(error: error));
    }, (courses) {
      emit(CourseStateLoaded(courses: courses));
    });
  }
}
