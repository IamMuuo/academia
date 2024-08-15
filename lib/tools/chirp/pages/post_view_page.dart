import 'package:academia/exports/barrel.dart';

class PostViewPage extends StatelessWidget {
  const PostViewPage({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            title: Text("@${post.username}"),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Text(
                post.title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
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
          SliverVisibility(
            visible: post.postAttachmentMedia.isNotEmpty,
            sliver: SliverToBoxAdapter(
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
        ],
      ),
    );
  }
}
