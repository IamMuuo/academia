part of 'referral_cubit.dart';

@immutable
sealed class ReferalState {}

final class ReferalInitialState extends ReferalState {}

final class ReferalLoading extends ReferalState {}

final class ReferalErrorState extends ReferalState {
  final String error;
  ReferalErrorState({required this.error});
}
