import 'package:academia/exports/barrel.dart';
import 'package:academia/models/models.dart';
import '../course_view_page.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
  });
  final Course course;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          borderRadius: BorderRadius.circular(4)),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => CourseViewPage(
                      course: course,
                    )),
          );
        },
        title: Text(
          course.unit,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            Row(
              children: [
                const Icon(
                  Ionicons.today,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  "Every: ",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Text(
                  course.dayOfWeek.title(),
                ),
                const Spacer(),
                const Icon(
                  Ionicons.location,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  "Venue: ",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Text(
                  course.room,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Ionicons.person_circle,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  "Lecturer: ",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Text(
                  course.lecturer.title(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(
                  Ionicons.time,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  "Time: ",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
                Text(
                  course.period,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
