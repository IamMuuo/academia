import 'package:academia/exports/barrel.dart';
import 'package:academia/pages/courses/widgets/course_card.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final EventsController eventsController = Get.find<EventsController>();
    final CoursesController coursesController = Get.find<CoursesController>();
    final TodoController todoController = Get.find<TodoController>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            pinned: true,
            floating: false,
            snap: false,
            leading: const SizedBox(width: 18),
            expandedHeight: 250,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/sketchbook-young-man-studying.png",
                    ),
                  ),
                ),
              ),
              title: const Text(
                "Life at glance",
              ),
            ),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stat(title: "Day", percentage: dayPercentGone() * 0.01),
                      Stat(title: "Week", percentage: weekPercentGone() * 0.01),
                      Obx(
                        () => Stat(
                          title: "Semester",
                          percentage: calculateSemesterPercent(
                                eventsController
                                        .currentSemester.value?.startDate ??
                                    DateTime.now(),
                                eventsController
                                        .currentSemester.value?.endDate ??
                                    DateTime.now(),
                              ) *
                              0.01,
                        ),
                      ),
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
                    width: 180,
                    height: 250,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/images/sketchbook-workspace-taking-notes-during-call-1.png",
                        ),
                        Text(
                          coursesController.courses.length.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const Text("Number of courses")
                      ],
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 250,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              Theme.of(context).colorScheme.primaryContainer),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/images/sketchbook-young-woman-chooses-book-1.png",
                        ),
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
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverVisibility(
              sliver: SliverToBoxAdapter(
                child: ExpansionTile(
                  initiallyExpanded: true,
                  maintainState: true,
                  enableFeedback: true,
                  title: Text(
                    "Today's classes",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .25,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(12),
                      child: coursesController.numberOfCoursesToday == 0
                          ? Column(
                              children: [
                                Text(
                                  "You have no classes today, take the day off complete assignments ${Emojis.smile_face_with_tongue}",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleSmall,
                                )
                              ],
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) {
                                final data =
                                    coursesController.coursesToday[index];
                                return CourseCard(course: data);
                              },
                              itemCount: coursesController.coursesToday.length,
                            ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverVisibility(
              sliver: SliverToBoxAdapter(
                child: ExpansionTile(
                  initiallyExpanded: false,
                  maintainState: true,
                  enableFeedback: true,
                  title: Text(
                    "Current Semester Events",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: FutureBuilder(
                        future: eventsController.semesterService
                            .fetchSemesterEvent(
                                eventsController.currentSemester.value?.id ??
                                    ""),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return snapshot.data!.fold(
                              (l) => SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Lottie.asset(
                                            "assets/lotties/error.json"),
                                        const SizedBox(height: 12),
                                        Text(
                                          "Holy .. $l",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                        ),
                                      ],
                                    ),
                                  ), (r) {
                            return ListView.separated(
                                itemBuilder: (context, index) {
                                  final data = r[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      child: Text((index + 1).toString()),
                                    ),
                                    title: Text(data.name),
                                    trailing: Icon(
                                      data.endDate.isBefore(DateTime.now())
                                          ? Ionicons.checkmark_done_circle
                                          : Ionicons.chevron_up_circle_outline,
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Starts: ${formatDateTime(data.startDate)}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "Ends: ${formatDateTime(data.endDate)}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 4),
                                itemCount: r.length);
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverVisibility(
              sliver: SliverToBoxAdapter(
                child: ExpansionTile(
                  initiallyExpanded: true,
                  maintainState: true,
                  enableFeedback: true,
                  title: Text(
                    "Today's tasks",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  children: [
                    Container(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      child: Obx(
                        () => todoController.filterTodosByDate("today").isEmpty
                            ? Text(
                                "You are clear for the day try visiting the library ${Emojis.smile_ghost}",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                            : Text(
                                "You have ${todoController.filterTodosByDate("today").length} due today",
                                style: Theme.of(context).textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
