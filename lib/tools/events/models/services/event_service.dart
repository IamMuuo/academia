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
        "Error communicating to server please chech your connection",
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
        "Error communicating to server please chech your connection",
      );
    }
  }
}
