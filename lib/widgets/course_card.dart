import 'package:academia/exports/barrel.dart';
import 'package:academia/models/models.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.course,
    required this.progress,
  });
  final Course course;
  final int progress;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.shadow),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          course.name!,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Time & Day",
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Ionicons.time_outline),
                            const SizedBox(width: 2),
                            Flexible(
                              child: Text(
                                course.period ?? "uknown time",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      overflow: TextOverflow.fade,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Ionicons.calendar_number_outline),
                            const SizedBox(width: 2),
                            Text(
                              course.dayOfTheWeek?.title() ?? "uknown day",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(4)),
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        top: 4,
                        left: 4,
                        right: 4,
                      ),
                      child: Column(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Icon(
                              Ionicons.person_circle_outline,
                            ),
                          ),
                          Text(
                            course.lecturer!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Location info",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Ionicons.location_outline),
                              Text(
                                course.room ?? "uknown venue",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 12),
              // LinearProgressIndicator(
              //   value: progress.toDouble(),
              // )
            ],
          ),
        ),
        Positioned(
          top: 5,
          left: 5,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(4)),
            child: const Row(
              children: [
                Text("In Progress"),
                SizedBox(width: 4),
                Icon(
                  Ionicons.radio,
                  size: 16,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
