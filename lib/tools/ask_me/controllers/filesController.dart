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
    await loadFiles();
    isLoading.value = false;

  }
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
}

