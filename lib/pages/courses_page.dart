import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final coursesController = Get.find<CoursesController>();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: const Text("Courses"),
          actions: [
            IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Courses"),
                    content: const Text(
                        "Here you can view your courses and everything in between"),
                    actions: [
                      FilledButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cool"))
                    ],
                  ),
                );
              },
              icon: const Icon(Ionicons.information_circle_outline),
            )
          ],
        ),
        SliverFillRemaining(
          child: Obx(
            () => coursesController.isLoading.value
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.beat(
                          size: 40,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Shazam ${Emojis.wheater_high_voltage}",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  )
                : coursesController.courses.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${Emojis.smile_downcast_face_with_sweat}Seems you are not registered for any course",
                            style: Theme.of(context).textTheme.titleLarge,
                            textAlign: TextAlign.center,
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              await coursesController.fetchCourses();
                            },
                            icon: const Icon(Ionicons.refresh),
                            label: const Text("Check again"),
                          ),
                        ],
                      )
                    : ListView.builder(
                        itemCount: coursesController.courses.length,
                        itemBuilder: (context, index) {
                          return CourseCard(
                            course: coursesController.courses[index],
                            progress: 9,
                          );
                        },
                      ),
          ),
        ),
      ],
    );
  }
}
