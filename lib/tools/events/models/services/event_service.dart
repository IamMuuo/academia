import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../models.dart';

class EventsService {
  // static const String eventUrlPrefix = "http://notifier.erick.serv00.net";
  static const String eventUrlPrefix = "http://localhost:8080";

  Future<Either<String, List<Event>>> fetchDueEvents() async {
    try {
      final response = await http
          .get(Uri.parse("${EventsService.eventUrlPrefix}/events/due"));

      if (response.statusCode == 200) {
        final body = json.decode(response.body).cast<Map<String, dynamic>>();
        return right(body.map((e) => Event.fromJson(e)).toList().cast<Event>());
      }

      return const Left("We are maintaining the server please try again later");
    } catch (e) {
      return const Left(
        "Error communicating to server please check your connection",
      );
    }
  }

  Future<Either<String, List<Event>>> fetchAllEvents() async {
    try {
      final response = await http
          .get(Uri.parse("${EventsService.eventUrlPrefix}/events/all"));

      if (response.statusCode == 200) {
        final body = json.decode(response.body).cast<Map<String, dynamic>>();
        return right(body.map((e) => Event.fromJson(e)).toList().cast<Event>());
      }

      return const Left("We are maintaining the server please try again later");
    } catch (e) {
      return const Left(
        "Error communicating to server please check your connection",
      );
    }
  }

  Future<Either<String, List<Event>>> fetchLikedEvents(String userID) async {
    try {
      final response = await http.get(
          Uri.parse("${EventsService.eventUrlPrefix}/events/liked-by/$userID"));

      if (response.statusCode == 200) {
        final body = json.decode(response.body).cast<Map<String, dynamic>>();
        return right(body.map((e) => Event.fromJson(e)).toList().cast<Event>());
      }

      return const Left("We are maintaining the server please try again later");
    } catch (e) {
      return const Left(
        "Error communicating to server please check your connection",
      );
    }
  }

  Future<Either<String, bool>> isEventLikedByUser(
      String userID, String eventID) async {
    try {
      final response = await http.get(Uri.parse(
          "${EventsService.eventUrlPrefix}/events/is-liked-by/$eventID/$userID"));

      if (response.statusCode == 200) {
        return right(true);
      }
      return right(false);
    } catch (e) {
      return const Left(
        "Error communicating to server please check your connection",
      );
    }
  }

  Future<Either<String, bool>> likeEvent(
    String userID,
    String eventID,
    bool attending,
  ) async {
    try {
      final response = await http.post(
          Uri.parse("${EventsService.eventUrlPrefix}/events/like"),
          headers: {"Content-Type": "application/json"},
          body: json.encode(
              {"user": userID, "event": eventID, "attending": attending}));

      if (response.statusCode == 201) {
        final body = json.decode(response.body) as Map<String, dynamic>;
        // if the id is null the user has unliked the pose
        if (body["id"] == null) {
          return right(false);
        }
        // otherwise the user likes the post
        return right(true);
      }

      return const Left("We are maintaining the server please try again later");
    } catch (e) {
      return const Left(
        "Error communicating to server please check your connection",
      );
    }
  }
}
