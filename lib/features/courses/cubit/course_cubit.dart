import 'package:academia/database/database.dart';
import 'package:academia/features/courses/cubit/course_state.dart';
import 'package:academia/features/courses/repository/course_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseCubit extends Cubit<CourseState> {
  final CourseRepository _courseRepository = CourseRepository();
  CourseCubit() : super(CourseStateInitial());

  Future<void> syncCourses(UserData user) async {
    emit(CourseStateLoading());
    final res = await _courseRepository.syncCoursesWithMagnet(user);
    if (res.isLeft()) {
      emit(CourseStateError(error: (res as Left).value));
    }
    emit(CourseStateLoaded(courses: (res as Right).value));
  }

  Future<void> fetchCachedCourses(UserData user) async {
    emit(CourseStateLoading());
    final result = await _courseRepository.fetchAllCachedCourses(user);
    result.fold((error) {
      emit(CourseStateError(error: error));
    }, (courses) {
      emit(CourseStateLoaded(courses: courses));
    });
  }
}
