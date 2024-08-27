import 'package:academia/exports/barrel.dart';
import '../pages/post_create_page.dart';
import 'package:get/get.dart';
import '../widgets/widgets.dart';
import './feed_page.dart';
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
      body: DefaultTabController(
        length: 3,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text("Chirp"),
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
              ),
              pinned: true,
              floating: true,
              snap: true,
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Feed'),
                  Tab(text: "My Posts"),
                  Tab(text: "Upvoted"),
                ],
              ),
            ),
            SliverVisibility(
              visible: false,
              sliver: SliverPersistentHeader(
                floating: true,
                delegate:
                    PersistentStorySliverDelegate(child: const SizedBox()),
              ),
            ),
            SliverFillRemaining(
                child: TabBarView(children: [
              FeedPage(),
              Text("Holla"),
              Text("Moma"),
            ])),
          ],
        ),
      ),
    );
  }
}
