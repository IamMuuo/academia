import 'package:get/get.dart';
import '../models/models.dart';

class FilesController extends GetxController {
  RxList<Files> files = <Files>[].obs;
  RxList<Score> scores = <Score>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFiles();
  }

  Future<void> loadFiles() async {
    isLoading.value = true;

    // Fetch files
    // FilesModelHelper().queryAll().then((value) {
    //   files.value = value.map((e) => Files.fromJson(e)).toList();
    // });
    final fileData = await FilesModelHelper().queryAll();
    final filesList = fileData.map((e) => Files.fromJson(e)).toList();

    // Fetch all scores
    ScoresModelHelper().queryAll().then((value) {
      scores.value = value.map((e) => Score.fromJson(e)).toList();
    });
    // final scoreData = await ScoresModelHelper().queryAll();
    // scores.value = scoreData.map((e) => Score.fromJson(e)).toList();

    // Associate scores with files and calculate avgScore
    for (var file in filesList) {
      // Filter scores for the current file
      final fileScores = scores.where((score) => score.filesId == file.id).toList();
      //file.scores = fileScores; // Update file with associated scores

      // Calculate the average score
      if (fileScores.isNotEmpty) {
        final totalScore = fileScores.fold(0, (sum, score) => sum + score.score);
        file.avgScore = (totalScore / fileScores.length).round();
      } else {
        file.avgScore = 0; // Default to 0 if no scores are available
      }
    }

    files.value = filesList;
    isLoading.value = false;
  }

  Future<void> addFile({
    required String title,
    required String filePath,
    required List<int> scores,
  }) async {
    isLoading.value = true;

    // Create the file record
    final fileId = await FilesModelHelper().create({
      'title': title,
      'filePath': filePath,
      'avgScore': 0, // Initial avgScore, will be updated later
    });

    // Insert the individual scores
    for (int score in scores) {
      await ScoresModelHelper().create({
        'score': score,
        'filesId': fileId,
      });
    }

    // Reload files and scores
    await loadFiles();
    isLoading.value = false;

  }

  Future<void> updateFile({
    required int fileId,
    required String title,
    required String filePath,
    required List<int> scores,
  }) async {
    isLoading.value = true;

    // Update the file record
    await FilesModelHelper().update({
      'id': fileId,
      'title': title,
      'filePath': filePath,
      'avgScore': 0, // Placeholder for avgScore, will be updated after scores are processed
    });

    // Insert or update the scores
    for (int score in scores) {
      await ScoresModelHelper().create({
        'score': score,
        'filesId': fileId,
      });
    }

    // Reload files and scores
    await loadFiles();
    isLoading.value = false;
  }

  Future<void> deleteFile(Files file) async {
    isLoading.value = true;

    // Delete the file
    final data = await FilesModelHelper().delete(files.toJson());
    // Reload files and scores
    await loadFiles();
    isLoading.value = false;
  }
}
