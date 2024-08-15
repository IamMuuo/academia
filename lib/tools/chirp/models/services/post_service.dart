import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../models.dart';

class PostService with ChirpService {
  Future<Either<String, Map<String, dynamic>>> fetchPosts(
    Map<String, String> authHeaders, {
    int page = 1,
  }) async {
    try {
      final response = await http.get(
        Uri.parse("${ChirpService.urlPrefix}/posts/all?pages=$page"),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        int nextPage = page;
        // parse the posts and the next page
        final Map<String, dynamic> rawData = json.decode(response.body);
        if (rawData.containsKey("next") && rawData["next"] != null) {
          nextPage += 1;
        }

        final List<Post> posts = rawData["results"]
            .map((e) => Post.fromJson(e))
            .toList()
            .cast<Post>();

        return right({
          "posts": posts,
          "nextPage": nextPage,
        });
      }
      return left(
        json.decode(response.body)["error"],
      );
    } catch (e) {
      rethrow;
      return left(
        "Encountered an error we did, check your connection you must, ${e.toString()}",
      );
    }
  }
}
