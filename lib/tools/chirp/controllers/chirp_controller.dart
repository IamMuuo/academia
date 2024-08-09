import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import '../models/models.dart';
import 'package:dartz/dartz.dart';

class ChirpController extends GetxController {
  final PostService _service = PostService();
  UserController userController = Get.find<UserController>();
  RxList<Post> posts = RxList<Post>();
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint("Chirp Controller Loaded");
  }

  Future<Either<String, List<Post>>> fetchPosts() async {
    final result = await _service.fetchPosts(userController.authHeaders);

    return result.fold((l) {
      return left(l);
    }, (r) {
      posts.value = r["posts"];
      currentPage.value = r["nextPage"];
      return right(posts);
    });
  }
}
