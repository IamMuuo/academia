import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';

class ChirpController extends GetxController {
  final PostService _service = PostService();
  UserController userController = Get.find<UserController>();
  // Loading posts comments

  Future<Either<String, List<Post>>> fetchUserPosts() async {
    final result = await _service.fetchUserPosts(
        userController.authHeaders, userController.user.value!.id!);

    return result.fold((l) {
      return left(l);
    }, (r) {
      return right(r);
    });
  }

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
