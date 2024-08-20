import 'dart:convert';

import 'package:academia/models/core/reward/reward.dart';
import 'package:academia/models/core/user/user.dart';
import 'package:academia/models/services/services.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class RewardsService with VerisafeService {
  /// Fetches all student rewards stored in the server
  Future<Either<String, List<Reward>>> fetchUserRewards(
    String userID,
    Map<String, String> tokenHeaders,
  ) async {
    try {
      final response = await http.get(
        Uri.parse(
          "${VerisafeService.urlPrefix}/rewards/awards/$userID",
        ),
        headers: tokenHeaders,
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body).cast<Map<String, dynamic>>();
        final rewards =
            body.map((e) => Reward.fromJson(e)).toList().cast<Reward>();
        return right(rewards);
      }

      return Left(
        json.decode(response.body)["error"],
      );
    } catch (e) {
      if (e is http.ClientException) {
        return const Left(
            "Error communicating to server please check your network and try again later");
      }
      return Left(e.toString());
    }
  }

  Future<Either<String, Reward>> award(
      Reward r, Map<String, String> tokenHeaders) async {
    try {
      final response = await http.post(
        Uri.parse("${VerisafeService.urlPrefix}/rewards/award"),
        body: json.encode(r.toJson()),
        headers: tokenHeaders,
      );

      if (response.statusCode == 201) {
        final body = json.decode(response.body);
        return right(Reward.fromJson(body));
      }
      return Left(
        json.decode(response.body)["error"],
      );
    } catch (e) {
      if (e is http.ClientException) {
        return const Left(
            "Error communicating to server please check your network and try again later");
      }
      return Left(e.toString());
    }
  }

  Future<Either<String, List<User>>> fetchLeaderBoard(
      Map<String, String> tokenHeaders) async {
    try {
      final response = await http.get(
        Uri.parse(
          "${VerisafeService.urlPrefix}/rewards/leaderboard",
        ),
        headers: tokenHeaders,
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body).cast<Map<String, dynamic>>();
        final users = body.map((e) => User.fromJson(e)).toList().cast<User>();

        return right(users);
      }

      return Left(
        json.decode(response.body)["error"],
      );
    } catch (e) {
      if (e is http.ClientException) {
        return const Left(
            "Error communicating to server please check your network and try again later");
      }
      return Left(e.toString());
    }
  }
}
