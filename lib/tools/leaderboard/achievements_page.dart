import 'package:academia/exports/barrel.dart';
import 'package:academia/models/core/reward/reward.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class AchievementPage extends StatefulWidget {
  const AchievementPage({super.key});

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage>
    with AutomaticKeepAliveClientMixin {
  final rewardsController = Get.find<RewardController>();
  @override
  bool get wantKeepAlive => true;

  String dateFormat(DateTime date) {
    return DateFormat('EEEE, MMMM d, y').format(date);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        final result = await rewardsController.fetchCurrentUserRewards();
        result.fold((l) => null, (r) async {
          await RewardModelHelper().truncate();
        });
        setState(() {});
      },
      child: FutureBuilder(
        future: rewardsController.loadRewards(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Column(
              children: [
                Lottie.asset(
                  "assets/lotties/fetching.json",
                ),
                const SizedBox(height: 18),
                Text(
                  "Fetching your vibe ...",
                  style: Theme.of(context).textTheme.headlineLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }
          return snapshot.data!.fold((l) {
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
          }, (r) {
            return ListView.builder(
              itemCount: r.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      child: Text(
                        (index + 1).toString(),
                      ),
                    ),
                    title: Text(
                      r[index].reason,
                    ),
                    subtitle: Text(
                      dateFormat(r[index].awardedAt),
                    ),
                    trailing: Text(" + ${r[index].points.toString()}"),
                  ),
                );
              },
            );
          });
        },
      ),
    );
  }
}
