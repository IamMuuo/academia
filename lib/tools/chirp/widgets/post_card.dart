import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import '../pages/post_view_page.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends StatefulWidget {
  const PostCard({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int upvotes = 0;
  int downvotes = 0;
  PostService ps = PostService();
  final UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    upvotes = widget.post.upvotes;
    downvotes = widget.post.downvotes;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PostViewPage(
            post: widget.post,
          ),
        ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.post.user!.profilePhoto != null &&
                        widget.post.user!.profilePhoto != ""
                    ? CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          widget.post.user?.profilePhoto ?? '',
                        ),
                      )
                    : Image.asset(
                        "assets/images/male_student.png",
                        height: 30,
                      ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "@${widget.post.user?.username ?? 'anon'}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        timeago.format(widget.post.createdAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: widget.post.upvotes > 1000 ? true : false,
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Awesome post ✨✨"),
                              content: const Text(
                                  "This post has been handpicked by the community"),
                              actions: [
                                FilledButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cool"),
                                ),
                              ],
                            );
                          });
                    },
                    icon: const Icon(Ionicons.ribbon),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  widget.post.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Visibility(
                  visible: widget.post.postAttachmentMedia.isNotEmpty,
                  child: SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final data = widget.post.postAttachmentMedia[index];
                        return CachedNetworkImage(
                          imageUrl: data.image ?? "",
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 4),
                      itemCount: widget.post.postAttachmentMedia.length,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  utf8convert(trimTo99Characters(widget.post.content)),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Ionicons.arrow_up_circle_outline),
                  onPressed: () {
                    ps
                        .postVote(userController.authHeaders, "upvote",
                            widget.post.id)
                        .then((value) {
                      value.fold((l) {
                        debugPrint(l);
                      }, (r) {
                        if (r) {
                          setState(() {
                            upvotes++;
                          });
                        } else {
                          setState(() {
                            upvotes--;
                          });
                        }
                      });
                    });
                  },
                  label: Text(upvotes.toString()),
                ),
                const SizedBox(width: 4),
                OutlinedButton.icon(
                  label: Text(downvotes.toString()),
                  onPressed: () {
                    ps
                        .postVote(userController.authHeaders, "downvote",
                            widget.post.id)
                        .then((value) {
                      value.fold((l) {
                        debugPrint(l);
                      }, (r) {
                        if (r) {
                          setState(() {
                            downvotes++;
                          });
                        } else {
                          setState(() {
                            downvotes--;
                          });
                        }
                      });
                    });
                  },
                  icon: const Icon(Ionicons.arrow_down_circle_outline),
                ),
                const Spacer(),
                Row(
                  children: [
                    const Icon(
                      Ionicons.chatbubble_ellipses,
                    ),
                    const SizedBox(width: 8),
                    Text(widget.post.commentsCount.toString())
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
