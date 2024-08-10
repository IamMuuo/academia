import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/chirp/models/core/core.dart';
import 'package:academia/tools/chirp/pages/post_create_page.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import '../widgets/widgets.dart';
import '../controllers/chirp_controller.dart';

class ChirpHomePage extends StatefulWidget {
  const ChirpHomePage({super.key});

  @override
  State<ChirpHomePage> createState() => _ChirpHomePageState();
}

class _ChirpHomePageState extends State<ChirpHomePage> {
  final NotificationsController notificationsController =
      Get.find<NotificationsController>();
  final controller = Get.put(ChirpController());

  @override
  void initState() {
    super.initState();
    controller.fetchPosts().then((value) {
      value.fold((l) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text(l),
                actions: [
                  FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Okay"))
                ],
              );
            });
      }, (r) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LeaderBoardPage()));
              },
              icon: const Icon(Ionicons.trophy_outline),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Ionicons.search_outline),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EventsPage()));
                },
                icon: const Icon(Ionicons.flame_outline),
              )
            ],
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  image: const DecorationImage(
                    image: AssetImage(
                        "assets/images/sketchbook-passersby-people-working-around-1.png"),
                  ),
                ),
              ),
              title: const Text("Chirp"),
            ),
            pinned: true,
            floating: true,
            snap: true,
          ),
          SliverVisibility(
            visible: false,
            sliver: SliverPersistentHeader(
              floating: true,
              delegate: PersistentStorySliverDelegate(child: const SizedBox()),
            ),
          ),
          SliverFillRemaining(
            child: Obx(
              () => controller.isLoading.value
                  ? Column(
                      children: [
                        Lottie.asset("assets/lotties/fetching.json"),
                        const SizedBox(height: 22),
                        Text(
                          "Fetching posts",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        await controller.fetchPosts();
                      },
                      child: controller.posts.isEmpty
                          ? SingleChildScrollView(
                              child: Column(
                                children: [
                                  Lottie.asset("assets/lotties/empty.json"),
                                  Text(
                                    "Argh snap! We couldn't find posts at the moment. Please try again later",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ],
                              ),
                            )
                          : ListView.separated(
                              itemBuilder: (context, index) {
                                final data = controller.posts[index];
                                return PostCard(post: data);
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                child: Divider(
                                  thickness: 0.2,
                                ),
                              ),
                              itemCount: controller.posts.length,
                            ),
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PostCreatePage(),
            ),
          );
        },
        child: const Icon(Ionicons.add),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w800, color: Colors.grey),
                    ),
                    Text(
                      "20 mins ago",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Ionicons.ellipsis_horizontal_circle_outline),
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
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Row(
                  children: [
                    const Icon(
                      Ionicons.arrow_up_circle_outline,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      post.upvotes.toString(),
                      style: GoogleFonts.ubuntu(),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () {},
                icon: const Icon(Ionicons.arrow_down_circle_outline),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Ionicons.arrow_redo_outline),
              )
            ],
          )
        ],
      ),
    );
  }
}
