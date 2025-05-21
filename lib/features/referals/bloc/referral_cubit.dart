import 'package:academia/core/user/repository/user_remote_repository.dart';
import 'package:academia/core/user/repository/user_repository.dart';
import 'package:academia/database/database.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:magnet/magnet.dart';
import 'package:drift/drift.dart' as drift;

part 'referal_state.dart';

final class ReferralCubit extends Cubit<ReferalState> {
  ReferralCubit() : super(ReferalInitialState());
  final UserRemoteRepository _userRemoteRepository = UserRemoteRepository();

  final Logger _logger = Logger();

  Future<Either<String, Map<String, String>>> fetchUserDetailsFromMagnet(
      String admissionNumber, String password) async {
    if (admissionNumber.trim().isEmpty || password.trim().length < 6) {
      return left("Please enter a admission number");
    }
    if (password.trim().isEmpty) {
      return left("Please enter a valid admission number");
    }

    try {
      final Magnet magnet = Magnet(admissionNumber, password);
      final loginResponse = await magnet.login();

      if (loginResponse.isLeft()) {
        return left("Error: ${(loginResponse as Left).value}");
      }

      final userResponse = await magnet.fetchUserDetails();
      if (userResponse.isLeft()) {
        return left("Error: ${(userResponse as Left).value}");
      }

      final user = (userResponse as Right).value;
      _logger.d(user);
      user['profile'] = user['profile']!.split(',').last;
      user.addAll({'password': password});

      return right(user);
    } catch (e) {
      return left("Error: $e");
    }
  }

  Future<Either<String, String>> completeProfile(
    UserData user,
    UserCredentialData creds,
    UserProfileData profile,
  ) async {
    final userResult = await _userRemoteRepository.registerUser(user);
    if (userResult.isLeft()) {
      _logger.e((userResult as Left).value);
      return left((userResult as Left).value);
    }
    final id = ((userResult as Right).value as UserData).id;

    _logger.i(user.toJson());

    final credsResult = await _userRemoteRepository
        .registerUserCredentials(creds.copyWith(userId: drift.Value(id)));
    if (credsResult.isLeft()) {
      _logger.e((credsResult as Left).value);
      return left((credsResult as Left).value);
    }

    final dob = DateTime.now();
    final profileResult = await _userRemoteRepository.createUserProfile(
      profile.copyWith(
        userId: id,
        dateOfBirth: dob.copyWith(
          year: profile.dateOfBirth.year,
          month: profile.dateOfBirth.month,
          day: profile.dateOfBirth.day,
          isUtc: true,
        ),
      ),
    );
    if (profileResult.isLeft()) {
      _logger.e((profileResult as Left).value);
      return left((profileResult as Left).value);
    }

    return right("Thank you for registering ${user.firstname}");
  }
}
