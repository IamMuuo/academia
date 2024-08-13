import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/leaderboard/widgets/top_three_widget.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HallOfFamePage extends StatelessWidget {
  const HallOfFamePage({super.key});

  // @override
  // void initState() {
  //   super.initState();
  //   leaderBoardResult = rewardsController.fetchLeaderBoard();
  // }

  @override
  Widget build(BuildContext context) {
    final rewardsController = Get.find<RewardController>();
    // late Future<Either<String, List<User>>> leaderBoardResult;
    Future leaderBoardResult = rewardsController.fetchLeaderBoard();

    return FutureBuilder(
        future: leaderBoardResult,
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
                                profileUrl: r[1].profileUrl,
                                gender: r[1].gender,
                              ),
                              LeaderBoardProfileWidget(
                                position: 1,
                                username: r[0].username,
                                points: r[0].vibePoints.toString(),
                                profileUrl: r[0].profileUrl,
                                gender: r[0].gender,
                              ),
                              LeaderBoardProfileWidget(
                                position: 3,
                                username: r[2].username,
                                points: r[2].vibePoints.toString(),
                                profileUrl: r[2].profileUrl,
                                gender: r[2].gender,
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
                                          radius: 30,
                                          child: moreUsers[index]
                                                  .profileUrl
                                                  .startsWith("http")
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(60),
                                                  child: CachedNetworkImage(
                                                    imageUrl: moreUsers[index]
                                                        .profileUrl,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              : moreUsers[index].gender ==
                                                      "male"
                                                  ? Image.asset(
                                                      "assets/images/male_student.png")
                                                  : Image.asset(
                                                      "assets/images/female_student.png")),
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
