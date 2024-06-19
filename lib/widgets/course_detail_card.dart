import 'package:academia/exports/barrel.dart';

class CourseDetailCard extends StatelessWidget {
  const CourseDetailCard(
      {super.key,
      required this.courseCode,
      required this.dayOfWeek,
      required this.room,
      required this.time,
      required this.campus,
      required this.lecturer});
  final String courseCode;
  final String dayOfWeek;
  final String room;
  final String time;
  final String campus;
  final String lecturer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          dayOfWeek.title(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                courseCode.trim(),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Ionicons.person_circle_outline),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          lecturer.title(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          room.toUpperCase(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Ionicons.time_outline),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          time,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  Text(
                    campus.toUpperCase(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
