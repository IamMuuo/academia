import 'package:academia/exports/barrel.dart';
import 'package:academia/models/core/course/course_model.dart';
import 'package:academia/models/models.dart';
import 'package:get/get.dart';
import 'widgets/course_topic_form.dart';

class CourseViewPage extends StatelessWidget {
  const CourseViewPage({
    super.key,
    required this.course,
  });
  final Course course;

  @override
  Widget build(BuildContext context) {
    final CoursesController coursesController = Get.find<CoursesController>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            expandedHeight: 250,
            snap: true,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
              title: Text(course.unit),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverFillRemaining(
              child: Obx(
                () => coursesController.coursesTopics
                        .where((p0) => p0.course == course.unit)
                        .toList()
                        .isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "No topics here, there are. Disappointed, I am. ${Emojis.smile_skull}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Tap the + button you must, to add a new topic",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                          ),
                        ],
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 4),
                        itemBuilder: (context, index) {
                          final data = coursesController.coursesTopics
                              .where((p0) => p0.course == course.unit)
                              .toList()[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .secondaryContainer,
                              ),
                            ),
                            child: ListTile(
                              title: Text(data.name),
                              subtitle: Text(
                                data.description == ""
                                    ? "A description, there is not. Lost, it seems."
                                    : data.description,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              leading: CircleAvatar(
                                child: Text((index + 1).toString()),
                              ),
                              trailing: IconButton(
                                onPressed: () async {
                                  await coursesController
                                      .deleteCourseTopic(data);

                                  HapticFeedback.heavyImpact().then((value) {
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text("Deleted successfully")));
                                  });
                                },
                                icon: const Icon(Ionicons.trash),
                              ),
                            ),
                          );
                        },
                        itemCount: coursesController.coursesTopics
                            .where((p0) => p0.course == course.unit)
                            .toList()
                            .length,
                        shrinkWrap: true,
                      ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            // elevation: 0,
            builder: (context) => Dialog(
                child: TopicForm(
              course: course,
            )),
          );
        },
        child: const Icon(Ionicons.add),
      ),
    );
  }
}
