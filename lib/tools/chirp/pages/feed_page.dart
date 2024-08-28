import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import '../widgets/widgets.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  bool pageLoading = true;
  bool morePostsLoading = false;
  List<Post> feedPosts = [];
  int nextPage = 1;
  bool hasMorePages = true;

  final UserController userController = Get.find<UserController>();
  final PostService _service = PostService();
  @override
  void initState() {
    super.initState();
    _service.fetchPosts(userController.authHeaders).then((value) {
      value.fold((l) {
        debugPrint(l);
      }, (r) {
        feedPosts.addAll(r["posts"]);
        if (nextPage == r["nextPage"]) {
          setState(() {
            hasMorePages = false;
          });
          return;
        }

        nextPage = r["nextPage"];
        setState(() {});
      });
    });
    setState(() {
      pageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return pageLoading
        ? ListView.separated(
            itemBuilder: (context, index) {
              return const EmptyPostCard();
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 4,
                ),
            itemCount: 12)
        : feedPosts.isEmpty
            ? const Center(
                child: Text("No posts here yet"),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  if (index < feedPosts.length) {
                    final post = feedPosts[index];
                    return PostCard(post: post);
                  }
                  return hasMorePages
                      ? morePostsLoading
                          ? const LinearProgressIndicator()
                          : TextButton(
                              onPressed: fetchMorePosts,
                              child: const Text("Load more"),
                            )
                      : const Text("You have reached the end of feed!");
                },
                separatorBuilder: (context, index) => const SizedBox(height: 2),
                itemCount: feedPosts.length + 1);
  }

  Future<void> fetchMorePosts() async {
    setState(() {
      morePostsLoading = true;
    });

    _service
        .fetchPosts(userController.authHeaders, page: nextPage)
        .then((value) {
      value.fold((l) {
        debugPrint(l);
      }, (r) {
        feedPosts.addAll(r["posts"]);
        setState(() {});
        if (nextPage == r["nextPage"]) {
          hasMorePages = false;
          return;
        }
        nextPage = r["nextPage"];
      });
    });

    setState(() {
      morePostsLoading = false;
    });
  }
}
