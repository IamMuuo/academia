import 'dart:convert';

import 'package:dartz/dartz.dart';
import '../models.dart';
import 'package:http/http.dart' as http;

class StoryService {
  static const String storyUrlPrefix = "http://localhost:8080";

  /// Future fetch Organizations
  Future<Either<String, List<Organization>>> fetchAllOrganizations() async {
    try {
      final response = await http.get(
        Uri.parse("${StoryService.storyUrlPrefix}/organizations/all"),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body).cast<Map<String, dynamic>>();
        return right(body
            .map((e) => Organization.fromJson(e))
            .toList()
            .cast<Organization>());
      }

      return left(
        "We encountered a problem while attempting to fetch organizations",
      );
    } catch (e) {
      return left(
        "Error communicating to server please check your connection and try again",
      );
    }
  }

  /// Fetch stories
  Future<Either<String, List<Story>>> fetchDueStories() async {
    try {
      final response = await http.get(
        Uri.parse("${StoryService.storyUrlPrefix}/stories/all"),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body).cast<Map<String, dynamic>>();
        return right(body.map((e) => Story.fromJson(e)).toList().cast<Story>());
      }

      return left(
        "We encountered a problem while attempting to fetch stories",
      );
    } catch (e) {
      rethrow;
      // return left(
      //   "Error communicating to server please check your connection and try again",
      // );
    }
  }
}
