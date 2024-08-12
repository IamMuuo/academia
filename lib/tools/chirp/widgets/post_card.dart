import 'package:academia/exports/barrel.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                child: ProfilePictureWidget(
                  profileSize: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "@${post.username}",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    Text(
                      "20 mins ago",
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
              Text(
                trimTo99Characters(post.content),
              ),
            ],
          ),
          Visibility(
            visible: post.postAttachmentMedia.isNotEmpty,
            child: SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final data = post.postAttachmentMedia[index];
                  return CachedNetworkImage(
                    imageUrl: data.image,
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                  );
                },
                itemCount: post.postAttachmentMedia.length,
              ),
            ),
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
            ],
          )
        ],
      ),
    );
  }
}
