// The base profile state
import 'package:academia/database/database.dart';

class ProfileState {}

// Profile initial
class ProfileInitalState extends ProfileState {}

/// Profile loading state
class ProfileLoadingState extends ProfileState {}

/// Profile error state
class ProfileErrorState extends ProfileState {
  final String error;
  ProfileErrorState({required this.error});
}

/// Profile loaded state
class ProfileLoadedState extends ProfileState {
  final UserProfileData userProfiles;
  ProfileLoadedState({required this.userProfiles});
}
