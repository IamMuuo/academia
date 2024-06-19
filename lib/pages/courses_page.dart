import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  final coursesController = Get.find<CoursesController>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        final result = await coursesController.fetchUserCourses();
        result.fold(
            (l) => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Oops!"),
                    content: Text(l),
                    actions: [
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Ooh, ok"),
                      )
                    ],
                  ),
                ), (r) {
          setState(
            () {},
          );
        });
      },
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            title: const Text("Courses"),
            actions: [
              IconButton(
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Courses"),
                      content: const Text(
                        "Here you can view your courses and everything in between",
                      ),
                      actions: [
                        FilledButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cool"),
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(Ionicons.information_circle_outline),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverFillRemaining(
              child: coursesController.courses.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Lottie.asset("assets/lotties/empty.json"),
                        Text(
                          "You have no courses yet. Once you register we will display them here.",
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        )
                      ],
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        final course = coursesController.courses[index];
                        return CourseDetailCard(
                          courseCode: course.unit,
                          room: course.room,
                          time: course.period,
                          campus: course.campus,
                          dayOfWeek: course.dayOfWeek,
                          lecturer: course.lecturer,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 12,
                        );
                      },
                      itemCount: coursesController.courses.length,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
