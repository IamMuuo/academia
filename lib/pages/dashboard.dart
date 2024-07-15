import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final StoryController storyController = Get.find<StoryController>();
    final CoursesController coursesController = Get.find<CoursesController>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const LeaderBoardPage()));
              },
              icon: const Icon(Ionicons.trophy_outline),
            ),
            title: const Text("Academia"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const EventsPage()));
                },
                icon: const Icon(Ionicons.time),
              )
            ],
            pinned: true,
            floating: false,
            snap: false,
          ),
          // Obx(
          //   () => const SliverVisibility(
          //     sliver: SliverToBoxAdapter(
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.stretch,
          //         children: [
          //           HomeScreenStoryWidget(),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stat(title: "Day", percentage: dayPercentGone() * 0.01),
                      Stat(title: "Week", percentage: weekPercentGone() * 0.01),
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                    ),
                    child: Column(
                      children: [
                        Text(
                          coursesController.courses.length.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const Text("Number of courses")
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                    ),
                    child: Column(
                      children: [
                        Text(
                          coursesController.numberOfCoursesToday.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const Text("Courses today")
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
