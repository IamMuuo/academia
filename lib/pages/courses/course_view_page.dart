import 'package:academia/exports/barrel.dart';
import 'package:academia/models/models.dart';
import 'widgets/course_topic_form.dart';

class CourseViewPage extends StatelessWidget {
  const CourseViewPage({
    super.key,
    required this.course,
  });
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
          const SliverPadding(
            padding: EdgeInsets.all(12),
            sliver: SliverFillRemaining(
              child: Center(
                child: Text("Hi"),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              elevation: 0,
              builder: (context) => const TopicForm());
        },
        child: const Icon(Ionicons.add),
      ),
    );
  }
}
