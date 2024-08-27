import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';

class ChirpController extends GetxController {
  final PostService _service = PostService();
  UserController userController = Get.find<UserController>();
  RxList<Post> posts = RxList<Post>();
  RxInt currentPage = 0.obs;
  RxBool feedLoading = false.obs;
  RxBool myPostsLoading = false.obs;
  RxBool upvotedPostsLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    debugPrint("Chirp Controller Loaded");
  }

  Future<Either<String, List<Post>>> fetchPosts({
    bool nextPage = false,
    previousPage = false,
  }) async {
    feedLoading.value = true;

    int page = 1;

    if (nextPage) {
      page = currentPage.value;
    } else if (previousPage && currentPage > 1) {
      page = currentPage.value -= 1;
    }
    final result =
        await _service.fetchPosts(userController.authHeaders, page: page);
    feedLoading.value = false;

    return result.fold((l) {
      return left(l);
    }, (r) {
      posts.value = r["posts"];
      currentPage.value = r["nextPage"];
      return right(posts);
    });
  }

  // Loading posts comments
  Future<Either<String, List<Comment>>> fetchPostComments(Post post) async {
    final result =
        await _service.fetchPostComments(userController.authHeaders, post.id);

    return result.fold((l) {
      return left(l);
    }, (r) {
      return right(r);
    });
  }

  Future<Either<String, Post>> createPost(String title, String content) async {
    final Post newPost = Post(
      id: "",
      title: title,
      content: content,
      upvotes: 0,
      downvotes: 0,
      isEdited: false,
      isDeleted: false,
      createdAt: DateTime.now(),
      modifiedAt: DateTime.now(),
      commentsCount: 0,
      postAttachmentMedia: [],
    );

    return _service
        .createPost(
      userController.authHeaders,
      newPost,
      userController.user.value!.id!,
    )
        .then((value) {
      return value.fold((l) {
        return left(l);
      }, (r) {
        return right(r);
      });
    });
  }

  Future<Either<String, Comment>> postComment(String userID, String postID,
      String? parentCommentID, String content) async {
    final result = await _service.postComment(
      userController.authHeaders,
      userID,
      postID,
      parentCommentID,
      content,
    );

    return result.fold((l) {
      return left(l);
    }, (r) {
      return right(r);
    });
  }
}
