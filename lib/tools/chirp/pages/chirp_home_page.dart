import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/chirp/controllers/chirp_controller.dart';
import '../pages/post_create_page.dart';
import '../widgets/widgets.dart';
import './feed_page.dart';
import './personal_posts.dart';
import 'package:get/get.dart';

class ChirpHomePage extends StatelessWidget {
  const ChirpHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ChirpController());
    return Scaffold(
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
              expandedHeight: 200,
              pinned: true,
              floating: true,
              snap: true,
              bottom: PreferredSize(
                  preferredSize: Size(MediaQuery.of(context).size.width, 160),
                  child: const Column(
                    children: [
                      StoryHeader(),
                      TabBar(tabs: [
                        Tab(text: 'Trending'),
                        Tab(text: "Your Posts"),
                        Tab(text: "Organizations"),
                      ]),
                    ],
                  )),
            ),
            const SliverFillRemaining(
              hasScrollBody: true,
              fillOverscroll: false,
              child: TabBarView(
                children: [
                  FeedPage(),
                  PersonalPostsPage(),
                  OrganizationsPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
