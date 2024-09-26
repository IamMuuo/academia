import 'package:get/get.dart';
import '../models/models.dart';

class FilesAndScoresController extends GetxController {
  RxList<AskMeFiles> files = <AskMeFiles>[].obs;
  RxList<AskMeScores> scores = <AskMeScores>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFilesAndScores();
  }

  Future<void> loadFilesAndScores() async {
    // Fetch files
    FilesModelHelper().queryAll().then((value) {
      files.value = value.map((e) => AskMeFiles.fromJson(e)).toList();
    });

    //Fetch all scores
    ScoresModelHelper().queryAll().then((value) {
      scores.value = value.map((e) => AskMeScores.fromJson(e)).toList();
    });
  }

   // Fetch scores by file ID
  // Future<void> fetchScoresByFileId(int fileId) async {
  //   final scoreList = await ScoresModelHelper().queryScoresByFileId(fileId);
  //   scores.value = scoreList.map((score) => AskMeScores.fromJson(score)).toList();
  // }

  //Adds Scores
  Future<bool> addScores(AskMeScores score) async {
    final id = await ScoresModelHelper().create(score.toJson());
    score.id = id;
    scores.add(score);

    // Reload files and scores
    await loadFilesAndScores(); 
    return id == 0 ? false : true; 
  }

  Future<bool> addFile(AskMeFiles file) async {
    final id = await FilesModelHelper().create(file.toJson());
    file.id = id;
    files.add(file);
    await loadFilesAndScores();
    return id == 0 ? false : true;
  }
   //Update an existing file
  Future<AskMeFiles> updateFile(AskMeFiles file) async {
    await FilesModelHelper().update(file.toJson());
    files[files.indexWhere((f) => f.id == file.id)] = file;  

    await loadFilesAndScores();
    return file;
  }

  // Delete a file and its associated scores
  Future<bool> deleteFile(AskMeFiles file) async {
    files.removeWhere((value) => file.id == value.id);
    int value = await FilesModelHelper().delete(file.toJson());
    // files.remove(file);

    await loadFilesAndScores();
    return value == 0 ? false : true;
  }

}

