import 'package:academia/database/database.dart';
import 'package:academia/features/auth/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './profile_state.dart';

final class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository _userRepository = UserRepository();
  ProfileCubit() : super(ProfileInitalState());

  /// Fetches the profile for a [User] specified by [user] from
  /// the local cache
  Future<Either<String, UserProfileData>> fetchUserProfileFromCache(
    UserData user,
  ) async {
    emit(ProfileLoadingState());
    final result = await _userRepository.fetchUserProfileFromCache(user);
    return result.fold((l) {
      emit(ProfileErrorState(error: l));
      return left(l);
    }, (r) {
      emit(ProfileLoadedState(userProfiles: r));
      return right(r);
    });
  }

  /// Fetches the profile for a [User] specified by [user] from
  /// the remote repo
  Future<Either<String, UserProfileData>> fetchUserProfileFromRemote(
    UserData user,
  ) async {
    emit(ProfileLoadingState());
    final result = await _userRepository.refreshUserProfile(user);
    return result.fold((l) {
      emit(ProfileErrorState(error: l));
      return left(l);
    }, (r) {
      emit(ProfileLoadedState(userProfiles: r));
      return right(r);
    });
  }
}
