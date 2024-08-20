import 'package:academia/exports/barrel.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:get/get.dart';
import '../controllers/chirp_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostViewPage extends StatelessWidget {
  const PostViewPage({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChirpController>();
    final userController = Get.find<UserController>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            title: Text("@${post.user?.username ?? 'anon'}"),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            sliver: SliverToBoxAdapter(
              child: Text(
                post.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          SliverVisibility(
            visible: post.postAttachmentMedia.isNotEmpty,
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final data = post.postAttachmentMedia[index];
                    return CachedNetworkImage(
                      imageUrl: data.image ?? "",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    );
                  },
                  itemCount: post.postAttachmentMedia.length,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Text(
                post.content,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Row(
                    children: [
                      const Icon(
                        Ionicons.arrow_up_circle_outline,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        post.upvotes.toString(),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 2),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Ionicons.arrow_down_circle_outline),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            fillOverscroll: true,
            child: Stack(
              children: [
                FutureBuilder(
                    future: controller.fetchPostComments(post),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return const Column(
                          children: [
                            Text("Fetching awesome comments"),
                          ],
                        );
                      }
                      return snapshot.data!.fold((l) {
                        return Text(l);
                      }, (r) {
                        return ListView.separated(
                            itemBuilder: (context, index) {
                              final data = r[index];
                              return CommentWidget(comment: data);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(),
                            itemCount: r.length);
                      });
                    }),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Send Reply",
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Ionicons.send),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
    required this.comment,
    this.showSubPosts = true,
  });
  final Comment comment;
  final bool showSubPosts;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final userController = Get.find<UserController>();
  final TextEditingController replyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      onRightSwipe: (data) {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            height: 120,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  "Send a reply to @${widget.comment.user.username}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 22),
                TextFormField(
                  controller: replyController,
                  decoration: const InputDecoration(
                    hintText: "Send a reply",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
              width: 2.0,
            ),
          ),
        ),
        padding: const EdgeInsets.all(2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                widget.comment.user.profilePhoto != null
                    ? CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          widget.comment.user.profilePhoto ?? '',
                        ),
                      )
                    : Image.asset(
                        "assets/images/male_student.png",
                        height: 30,
                      ),
                const SizedBox(width: 4),
                Text((userController.user.value?.id ?? "") ==
                        widget.comment.user.id
                    ? "You"
                    : "@${widget.comment.user.username}"),
                const SizedBox(width: 12),
                Text(
                  timeago.format(widget.comment.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.comment.content,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final data = widget.comment.replies[index];
                  return CommentWidget(
                    comment: data,
                    showSubPosts: index > 1 ? false : true,
                  );
                },
                itemCount: widget.comment.replies.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
