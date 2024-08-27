import 'package:get/get.dart';
import '../models/models.dart';

class FilesController extends GetxController {
  RxList<AskMeFiles> files = <AskMeFiles>[].obs;
  RxList<AskMeScores> scores = <AskMeScores>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFiles();
  }

  Future<void> loadFiles() async {
    isLoading.value = true;

    // Fetch files
    FilesModelHelper().queryAll().then((value) {
      files.value = value.map((e) => AskMeFiles.fromJson(e)).toList();
    });

    //Fetch all scores
    ScoresModelHelper().queryAll().then((value) {
      scores.value = value.map((e) => AskMeScores.fromJson(e)).toList();
    });
    // final fileData = await FilesModelHelper().queryAll();
    // final filesList = fileData.map((e) => AskMeFiles.fromJson(e)).toList();

    // Fetch all scores
    // ScoresModelHelper().queryAll().then((value) {
    //   scores.value = value.map((e) => AskMeScores.fromJson(e)).toList();
    // });
    // // final scoreData = await ScoresModelHelper().queryAll();
    // // scores.value = scoreData.map((e) => Score.fromJson(e)).toList();

    // // Associate scores with files and calculate avgScore
    // for (var file in filesList) {
    //   // Filter scores for the current file
    //   final fileScores = scores.where((score) => score.filesId == file.id).toList();
    //   //file.scores = fileScores; // Update file with associated scores

    //   // Calculate the average score
    //   if (fileScores.isNotEmpty) {
    //     final totalScore = fileScores.fold(0, (sum, score) => sum + score.score);
    //     file.avgScore = (totalScore / fileScores.length).round();
    //   } else {
    //     file.avgScore = 0; // Default to 0 if no scores are available
    //   }
    // }

    //files.value = filesList;
    isLoading.value = false;
  }

   // Fetch scores by file ID
  Future<void> fetchScoresByFileId(int fileId) async {
    isLoading.value = true;
    final scoreList = await ScoresModelHelper().queryScoresByFileId(fileId);
    scores.value = scoreList.map((score) => AskMeScores.fromJson(score)).toList();
  }

  //Adds Scores
  Future<void> addScores(AskMeScores score) async {
    isLoading.value = true;
    final id = await ScoresModelHelper().create(score.toJson());
    score.id = id;
    scores.add(score);

    // Reload files and scores
    await loadFiles();
    isLoading.value = false;
    
  }

  

  Future<void> addFile(AskMeFiles file) async {
    isLoading.value = true;
    final id = await FilesModelHelper().create(file.toJson());
    file.id = id;
    files.add(file);

    // for (int score in scores) {
    //   final scoreModel = AskMeScores(
    //     score: score,
    //     filesId: id,
    //   );
    // }
    // await ScoresModelHelper().create(scoreModel.toJson());

 

    // Reload files and scores
    await loadFiles();
    isLoading.value = false;

  }

// Future<void> addFile({
//   required String title,
//   required String filePath,
//   required List<int> scores,
// }) async {
//   isLoading.value = true;

//   // Create a Files object and serialize it to JSON
//   final file = AskMeFiles(
//     id: await fileId,
//     title: title,
//     filePath: filePath,
//     avgScore: 0, // Initial avgScore, will be updated later
//   );

//   // Insert the file into the database using the serialized JSON
//   final fileId = await FilesModelHelper().create(file.toJson());

//   // Insert the individual scores
//   for (int score in scores) {
//     final scoreModel = AskMeScores(
//       score: score,
//       filesId: fileId,
//     );
//     await ScoresModelHelper().create(scoreModel.toJson());
//   }

//   // Reload files and scores
//   await loadFiles();
//   isLoading.value = false;
// }


  // Future<void> updateFile({
  //   required int fileId,
  //   required String title,
  //   required String filePath,
  //   required List<int> scores,
  // }) async {
  //   isLoading.value = true;

  //   // Update the file record
  //   await FilesModelHelper().update({
  //     'id': fileId,
  //     'title': title,
  //     'filePath': filePath,
  //     'avgScore': 0, // Placeholder for avgScore, will be updated after scores are processed
  //   });

  //   // Insert or update the scores
  //   for (int score in scores) {
  //     await ScoresModelHelper().create({
  //       'score': score,
  //       'filesId': fileId,
  //     });
  //   }

  //   // Reload files and scores
  //   await loadFiles();
  //   isLoading.value = false;
  // }

   //Update an existing file
  Future<void> updateFile(AskMeFiles file) async {
    isLoading.value = true;
    await FilesModelHelper().update(file.toJson());
    files[files.indexWhere((f) => f.id == file.id)] = file;  

    await loadFiles();
    isLoading.value = false;
  }

  // Delete a file and its associated scores
  Future<void> deleteFile(AskMeFiles file) async {
    isLoading.value = true;
    await FilesModelHelper().delete(file.toJson());
    files.remove(file);

    await loadFiles();
    isLoading.value = false;
  }

  // Future<void> deleteFile(int fileId) async {
  //   isLoading.value = true;

  //   // Delete the file
  //   await FilesModelHelper().delete({'id': fileId});

  //   // Reload files and scores
  //   await loadFiles();
  //   isLoading.value = false;
  // }
}

