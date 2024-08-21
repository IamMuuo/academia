import 'package:academia/exports/barrel.dart';
import '../controllers/chirp_controller.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentWidget extends StatefulWidget {
  const CommentWidget({
    super.key,
    required this.comment,
    this.depth = 0,
  });
  final Comment comment;
  final int depth;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool showSubPosts = false;
  final userController = Get.find<UserController>();
  final chirpController = Get.find<ChirpController>();
  final TextEditingController replyController = TextEditingController();
  @override
  void initState() {
    super.initState();
    setState(() {
      showSubPosts = widget.depth > 0 ? false : true;
    });
  }

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
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        print(
                          userController.user.value!.id!,
                        );
                        final result = await chirpController.postComment(
                          userController.user.value!.id!,
                          widget.comment.post.id,
                          widget.comment.id,
                          replyController.text,
                        );
                        result.fold((l) {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("Error"),
                                    content: Text(l),
                                  ));
                        }, (r) {
                          setState(() {
                            widget.comment.replies.add(r);
                          });
                        });
                      },
                      icon: const Icon(Ionicons.send),
                    ),
                    hintText: "Send a reply",
                    border: const OutlineInputBorder(
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
              child: showSubPosts
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final data = widget.comment.replies[index];
                        return CommentWidget(
                          comment: data,
                          depth: widget.depth + 1,
                        );
                      },
                      itemCount: widget.comment.replies.length,
                    )
                  : Visibility(
                      visible: widget.comment.replies.isNotEmpty,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            showSubPosts = !showSubPosts;
                          });
                        },
                        child: const Text("Show replies"),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
