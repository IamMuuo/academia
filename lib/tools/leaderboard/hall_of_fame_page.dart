import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/leaderboard/widgets/top_three_widget.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HallOfFamePage extends StatefulWidget {
  const HallOfFamePage({super.key});

  @override
  State<HallOfFamePage> createState() => _HallOfFamePageState();
}

class _HallOfFamePageState extends State<HallOfFamePage> {
  final rewardsController = Get.find<RewardController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: rewardsController.fetchLeaderBoard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Column(
              children: [
                Lottie.asset(
                  "assets/lotties/fetching.json",
                ),
                const SizedBox(height: 18),
                Text(
                  "Fetching awesome vibes students",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }
          return snapshot.data?.fold((l) {
                return Column(
                  children: [
                    Lottie.asset(
                      "assets/lotties/error.json",
                      height: 60,
                    ),
                    const SizedBox(height: 18),
                    Text(
                      "Argh snap, $l",
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              },

                  // Please ensure that the api will atleast have 3 users
                  (r) {
                final moreUsers = r.sublist(3);
                return CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          height: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              LeaderBoardProfileWidget(
                                position: 2,
                                username: r[1].username,
                                points: r[1].vibePoints.toString(),
                              ),
                              LeaderBoardProfileWidget(
                                position: 1,
                                username: r[0].username,
                                points: r[0].vibePoints.toString(),
                              ),
                              LeaderBoardProfileWidget(
                                position: 3,
                                username: r[2].username,
                                points: r[2].vibePoints.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 16),
                      sliver: SliverFillRemaining(
                        child: moreUsers.isEmpty
                            ? Center(
                                child: Text(
                                  "Seems there's no content to display here yet.",
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ListView.builder(
                                itemCount: moreUsers.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        child: Text(index.toString()),
                                      ),
                                      title: Text(
                                        "@${moreUsers[index].username}",
                                      ),
                                      trailing: Icon(
                                        moreUsers[index].gender == "male"
                                            ? Ionicons.male
                                            : Ionicons.female,
                                      ),
                                      subtitle: Text(
                                        "${moreUsers[index].firstName} has ${moreUsers[index].vibePoints} vibe points",
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                );
              }) ??
              Column(
                children: [
                  Lottie.asset(
                    "assets/lotties/fetching.json",
                  ),
                  const SizedBox(height: 18),
                  Text(
                    "Fetching awesome vibes students",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              );
        });
  }
}
