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
        Uri.parse("${ChirpService.urlPrefix}/posts/all?page=$page"),
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
      return left(
        "Encountered an error we did, check your connection you must, ${e.toString()}",
      );
    }
  }

  Future<Either<String, Post>> createPost(
    Map<String, String> authHeaders,
    Post post,
    String userID,
  ) async {
    try {
      final rawPost = post.toJson();
      rawPost["user"] = userID;

      authHeaders.addAll({"Content-Type": "application/json"});
      final response = await http.post(
        Uri.parse("${ChirpService.urlPrefix}/posts/"),
        headers: authHeaders,
        body: json.encode(rawPost),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> rawPost = json.decode(response.body);
        return right(Post.fromJson(rawPost));
      }
      return left(
        json.decode(response.body)["error"] ?? "unknown error",
      );
    } catch (e) {
      return const Left("Please check your internet connection and try again");
    }
  }

  Future<Either<String, List<Post>>> fetchUserPosts(
      Map<String, String> authHeaders, String userID) async {
    try {
      final response = await http.get(
        Uri.parse("${ChirpService.urlPrefix}/posts/user/$userID"),
        headers: authHeaders,
      );
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> rawData =
            json.decode(response.body).cast<Map<String, dynamic>>();

        final List<Post> comments =
            rawData.map((e) => Post.fromJson(e)).toList().cast<Post>();

        return right(comments);
      }
      return left(
        json.decode(response.body)["error"],
      );
    } catch (e) {
      return left(
        "Encountered an error we did, check your connection you must, ${e.toString()}",
      );
    }
  }

  Future<Either<String, List<Comment>>> fetchPostComments(
    Map<String, String> authHeaders,
    String post, {
    int page = 1,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${ChirpService.urlPrefix}/comments/find-by-post/$post?pages=$page"),
        headers: authHeaders,
      );
      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> rawData =
            json.decode(response.body).cast<Map<String, dynamic>>();

        final List<Comment> comments =
            rawData.map((e) => Comment.fromJson(e)).toList().cast<Comment>();

        return right(comments);
      }
      return left(
        json.decode(response.body)["error"],
      );
    } catch (e) {
      return left(
        "Encountered an error we did, check your connection you must, ${e.toString()}",
      );
    }
  }

  Future<Either<String, Comment>> postComment(
      Map<String, String> authHeaders,
      String userID,
      String postID,
      String? parentCommentID,
      String content) async {
    try {
      authHeaders.addAll({"content-type": "application/json"});
      final response = await http.post(
          Uri.parse("${ChirpService.urlPrefix}/comments/create/"),
          headers: authHeaders,
          body: json.encode({
            "user": userID,
            "post": postID,
            "parent": parentCommentID,
            "content": content,
          }));

      if (response.statusCode == 201) {
        final Map<String, dynamic> rawComment = json.decode(response.body);
        return right(Comment.fromJson(rawComment));
      }
      return left(json.decode(response.body.toString()));
    } catch (e) {
      return Left("Failed to post comment error: ${e.toString()}");
    }
  }

  Future<Either<String, bool>> postVote(
      Map<String, String> authHeaders, String action, String postID) async {
    try {
      authHeaders.addAll({"content-type": "application/json"});
      final response = await http.get(
        Uri.parse("${ChirpService.urlPrefix}/posts/vote/$action/$postID"),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        return right(true);
      }
      if (response.statusCode == 404) {
        return right(false);
      }

      return left("Something went wrong while attempting to vote for post");
    } catch (e) {
      return left("Please check your internet connection and try again");
    }
  }
}
