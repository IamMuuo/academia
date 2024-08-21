import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import '../controllers/chirp_controller.dart';
import '../widgets/widgets.dart';

class PostViewPage extends StatelessWidget {
  const PostViewPage({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChirpController>();
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
                    color: Theme.of(context).colorScheme.surface,
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
