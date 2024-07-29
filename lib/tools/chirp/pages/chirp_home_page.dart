import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

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
                  notificationsController.createInstantNotification(
                    "Hello there",
                    "Hello again son",
                  );
                  notificationsController.scheduleNotification(
                    DateTime.now().add(Duration(minutes: 1)),
                    "Test",
                    "This is a mF big text notification",
                    notificationLayout: NotificationLayout.BigText,
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
            pinned: true,
            floating: true,
            snap: true,
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
