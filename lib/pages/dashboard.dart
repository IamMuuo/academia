import 'package:academia/exports/barrel.dart';
import 'package:academia/widgets/post_card.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    final userController = Get.find<UserController>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            leading:
                IconButton(onPressed: () {}, icon: const Icon(Ionicons.menu)),
            title: const Text("Academia"),
            pinned: true,
            floating: false,
            snap: false,
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Ionicons.add)),
              const ProfilePictureWidget(),
              const SizedBox(width: 8)
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "Quick statistics",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.surfaceTint),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    children: [
                      Stat(title: "Day", percentage: 0.2),
                      Stat(title: "Week", percentage: 0.2),
                      Stat(title: "Year", percentage: 0.2),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.red,
              width: 80,
              child: ListView(
                shrinkWrap: true,
                children: [],
              ),
            ),
          ),
          SliverFillRemaining(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: PostCard(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
