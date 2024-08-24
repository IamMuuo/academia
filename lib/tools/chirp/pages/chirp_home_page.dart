import 'package:academia/exports/barrel.dart';
import '../pages/post_create_page.dart';
import 'package:get/get.dart';
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
      value.fold((l) {}, (r) {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceDim,
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
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PostCreatePage(),
                    ),
                  );
                },
                icon: const Icon(Ionicons.add),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EventsPage()));
                },
                icon: const Icon(Ionicons.flame_outline),
              ),
            ],
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
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
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          Lottie.asset("assets/lotties/fetching.json"),
                          const SizedBox(height: 22),
                          Text(
                            "Fetching posts",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
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
                                height: 8,
                                child: Divider(thickness: 0.3),
                              ),
                              itemCount: controller.posts.length,
                            ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
