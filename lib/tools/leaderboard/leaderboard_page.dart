import 'package:academia/exports/barrel.dart';
import 'package:academia/models/models.dart';
import 'package:academia/tools/leaderboard/widgets/top_three_widget.dart';
import 'widgets/personal_rating_widget.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 12),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              pinned: true,
              title: const Text("Leaderboard"),
              actions: [
                IconButton(
                    onPressed: () {
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Introducing Vibe points"),
                          content: const SizedBox(
                            height: 200,
                            child: Column(
                              children: [
                                Icon(
                                  Ionicons.medal_outline,
                                  size: 120,
                                ),
                                Text(
                                    "Vibe Points keep you hyped while you learn. Rack up as many points as you can to score rewards and flex on your friends!")
                              ],
                            ),
                          ),
                          actions: [
                            FilledButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cool Feature"),
                            )
                          ],
                        ),
                      );
                    },
                    icon: const Icon(Ionicons.information_circle_outline))
              ],
            ),
            // const SliverToBoxAdapter(
            //   child: PersonalRatingWidget(),
            // ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              sliver: SliverToBoxAdapter(
                child: DefaultTabController(
                  length: 2,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const TabBar(
                          enableFeedback: true,
                          tabs: [
                            Tab(
                              text: "Top ranking",
                            ),
                            Tab(
                              text: "Personal",
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          height: 200,
                          child: TabBarView(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // LeaderBoardProfileWidget(
                                  //   position: 3,
                                  //   user: User(),
                                  // ),
                                  // LeaderBoardProfileWidget(
                                  //   position: 1,
                                  //   user: User(),
                                  // ),
                                  // LeaderBoardProfileWidget(
                                  //   position: 2,
                                  //   user: User(),
                                  // ),
                                ],
                              ),
                              const PersonalRatingWidget(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Top 25 flex list ${Emojis.smile_smiling_face_with_smiling_eyes}",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: true,
              child: ListView.builder(itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ListTile(
                    title: Text(
                      "@erick",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    trailing: const Text(
                      "150 Points",
                    ),
                    leading: const CircleAvatar(
                      radius: 60,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
