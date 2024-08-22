import 'package:academia/exports/barrel.dart';
import '../pages/post_view_page.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PostViewPage(
            post: post,
          ),
        ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                post.user!.profilePhoto != null
                    ? CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          post.user?.profilePhoto ?? '',
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
                        "@${post.user?.username ?? 'anon'}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      Text(
                        timeago.format(post.createdAt),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Ionicons.ellipsis_vertical),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 4),
                Visibility(
                  visible: post.postAttachmentMedia.isNotEmpty,
                  child: SizedBox(
                    height: 200,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final data = post.postAttachmentMedia[index];
                        return CachedNetworkImage(
                          imageUrl: data.image ?? "",
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 4),
                      itemCount: post.postAttachmentMedia.length,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  trimTo99Characters(post.content),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Row(
                    children: [
                      const Icon(
                        Ionicons.arrow_up_circle_outline,
                      ),
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
                const Spacer(),
                IconButton(
                  onPressed: null,
                  icon: Row(
                    children: [
                      const Icon(Ionicons.chatbox_outline),
                      const SizedBox(width: 2),
                      Text(post.commentsCount.toString())
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
