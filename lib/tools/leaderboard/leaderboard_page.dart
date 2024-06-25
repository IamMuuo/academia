import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/leaderboard/hall_of_fame_page.dart';
import 'achievements_page.dart';

class LeaderBoardPage extends StatelessWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text("Academia LeaderBoard"),
              bottom: TabBar(
                tabs: [
                  Tab(text: "Hall of Fame"),
                  Tab(text: "Personal Achievements"),
                ],
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(children: [
                HallOfFamePage(),
                AchievementPage(),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
