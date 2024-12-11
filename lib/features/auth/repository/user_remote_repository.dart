import 'package:academia/database/database.dart';
import 'package:academia/utils/network/dio_client.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

final class UserRemoteRepository {
  final DioClient _client = DioClient();

  /// The function attempts to authenticate a users [credentials] with
  /// verisafe. If okay it returns the [UserData] otherwise it just
  /// returns a string with a message of what exactly went wrong
  Future<Either<String, UserData>> verisafeAuthentication(
    UserCredentialData credentials,
  ) async {
    try {
      final response = await _client.dio.post(
        "/auth/authenticate",
        data: credentials.toJson(),
      );

      if (response.statusCode == 200) {
        return right(UserData.fromJson(response.data));
      }

      return left(response.data["error"] ?? response.statusMessage);
    } on DioException catch (de) {
      return left(de.response?.data["error"] ?? de.response!.statusMessage);
    } catch (e) {
      return left("Please check your internet connection and try that again!");
    }
  }
}
