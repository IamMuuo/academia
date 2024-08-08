import 'package:academia/exports/barrel.dart';
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
                onPressed: () {
                  Workmanager().registerPeriodicTask(
                    BackgroundConfig.refresh,
                    BackgroundConfig.refresh,
                    inputData: {"user": "hey"},
                  );
                },
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
              pinned: true,
              floating: true,
              delegate: PersistentStorySliverDelegate(
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.red,
                ),
              ),
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
        onPressed: () {},
        child: const Icon(
          Ionicons.shapes_outline,
        ),
      ),
    );
  }
}
