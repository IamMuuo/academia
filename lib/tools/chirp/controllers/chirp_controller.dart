import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import '../models/models.dart';
import 'package:dartz/dartz.dart';

class ChirpController extends GetxController {
  final PostService _service = PostService();
  UserController userController = Get.find<UserController>();
  RxList<Post> posts = RxList<Post>();
  RxInt currentPage = 0.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint("Chirp Controller Loaded");
  }

  Future<Either<String, List<Post>>> fetchPosts({
    bool nextPage = false,
    previousPage = false,
  }) async {
    isLoading.value = true;

    int page = 1;

    if (nextPage) {
      page = currentPage.value;
    } else if (previousPage && currentPage > 1) {
      page = currentPage.value -= 1;
    }
    final result =
        await _service.fetchPosts(userController.authHeaders, page: page);
    isLoading.value = false;

    return result.fold((l) {
      return left(l);
    }, (r) {
      posts.value = r["posts"];
      currentPage.value = r["nextPage"];
      return right(posts);
    });
  }
}
