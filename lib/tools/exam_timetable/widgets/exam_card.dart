import 'package:academia/exports/barrel.dart';

class ExamCard extends StatelessWidget {
  const ExamCard({super.key, required this.exam, this.ispast = false});
  final Exam exam;
  final bool ispast;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).colorScheme.secondaryContainer,
        ),
        child: ListTile(
          enabled: !ispast,
          leading: const Icon(Ionicons.ribbon),
          title: Text(
            exam.courseCode.toString(),
          ),
          subtitle: Column(
            children: [
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Ionicons.calendar),
                  const SizedBox(width: 4),
                  Text(
                    exam.day,
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Ionicons.location),
                  const SizedBox(width: 4),
                  Text(
                    exam.venue,
                  ),
                  const Spacer(),
                  const Icon(Ionicons.time),
                  const SizedBox(width: 2),
                  Text(
                    exam.time,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              exam.coordinator != null && exam.invigilator != null
                  ? Column(children: [
                      Row(
                        children: [
                          Text(
                            "Coordiator: ${exam.coordinator.toString().title()}",
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            "Invigilator ${exam.invigilator.toString().title()}",
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                    ])
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
