import 'package:academia/exports/barrel.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class StoryService with ChirpService {
  Future<Either<String, List<Map<String, List<Story>>>>> fetchStories(
      Map<String, String> authHeaders) async {
    try {
      final response = await http.get(
        Uri.parse("${ChirpService.urlPrefix}/stories/"),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> rawData = json.decode(response.body);

        List<Map<String, List<Story>>> parsedStories =
            rawData.entries.map((entry) {
          // Organization ID is the key
          String organizationId = entry.key;

          // The value is a List of story JSON objects
          List<dynamic> storiesJson = entry.value;

          // Parse each story JSON into a Story model
          List<Story> stories = storiesJson
              .map((storyJson) =>
                  Story.fromJson(storyJson as Map<String, dynamic>))
              .toList();

          // Return a map with organization ID and corresponding list of Story objects
          return {organizationId: stories};
        }).toList();

        // Return the parsed stories wrapped in a Right
        return Right(parsedStories);
      }

      return const Left(
        "Something went wrong white attempting to fetch organizations",
      );
    } catch (e) {
      return const Left(
        "Please check your internet connection and try that again",
      );
    }
  }

  Future<Either<String, bool>> markStoryAsViewed(
    Map<String, String> authHeaders,
    String storyID,
  ) async {
    try {
      final response = await http.get(
        Uri.parse("${ChirpService.urlPrefix}/stories/view/$storyID/"),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        return right(true);
      }

      return const Left(
        "Something went wrong white attempting to mark story as viewed",
      );
    } catch (e) {
      return const Left(
        "Please check your internet connection and try that again",
      );
    }
  }
}
