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
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cool"),
                      )
                    ],
                  ),
                );
              },
              icon: const Icon(Ionicons.information_circle_outline),
            )
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate(
              childCount: 2,
              (context, index) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      width: 2,
                      color: Theme.of(context).colorScheme.primary,
                    )),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${Emojis.flag_Kenya}",
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            padding: const EdgeInsets.all(12),
            child: const Text(
              "${Emojis.symbols_information} You have no courses today",
            ),
          ),
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
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: ListView.builder(
                          itemCount: coursesController.courses.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: CourseCard(
                                course: coursesController.courses[index],
                                progress: 9,
                              ),
                            );
                          },
                        ),
                      ),
          ),
        ),
      ],
    );
  }
}
