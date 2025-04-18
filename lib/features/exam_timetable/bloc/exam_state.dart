part of 'exam_bloc.dart';

@immutable
sealed class ExamState {}

final class ExamStateLoading extends ExamState {}

final class InitialExamState extends ExamState {}

final class ExamStateError extends ExamState {
  final String error;
  ExamStateError({required this.error});
}

final class ExamStateLoaded extends ExamState {
  final List<ExamModelData> userExams;
  final List<ExamModelData> fetchedExams;
  ExamStateLoaded({
    required this.userExams,
    required this.fetchedExams,
  }) {
    userExams.sort((a, b) => a.examDate.compareTo(b.examDate));
    fetchedExams.sort((a, b) => a.examDate.compareTo(b.examDate));
  }
}
