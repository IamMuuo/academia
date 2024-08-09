import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/chirp/pages/post_create_page.dart';
import 'package:get/get.dart';
import '../widgets/widgets.dart';

class ChirpHomePage extends StatefulWidget {
  const ChirpHomePage({super.key});

  @override
  State<ChirpHomePage> createState() => _ChirpHomePageState();
}

class _ChirpHomePageState extends State<ChirpHomePage> {
  final NotificationsController notificationsController =
      Get.find<NotificationsController>();
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
            visible: true,
            sliver: SliverPersistentHeader(
              floating: true,
              delegate: PersistentStorySliverDelegate(child: const SizedBox()),
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child: Text(
                "Coming soon!",
                style: Theme.of(context).textTheme.headlineMedium,
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
