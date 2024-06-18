import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/leaderboard/hall_of_fame_page.dart';
import 'achievements_page.dart';

class LeaderBoardPage extends StatefulWidget {
  const LeaderBoardPage({super.key});

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
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
