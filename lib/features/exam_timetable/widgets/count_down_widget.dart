import 'package:academia/database/database.dart';
import 'package:academia/exports/barrel.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';

class ExamCountDownWidget extends StatefulWidget {
  const ExamCountDownWidget({
    super.key,
    required this.exams,
  });
  final List<ExamModelData> exams;

  @override
  State<ExamCountDownWidget> createState() => _ExamCountDownWidgetState();
}

class _ExamCountDownWidgetState extends State<ExamCountDownWidget> {
  late ExamModelData? upcomingExam;
  ExamModelData? _findUpcomingExam(List<ExamModelData> exams) {
    final now = DateTime.now();
    exams
        .sort((a, b) => a.examDate.compareTo(b.examDate)); // Sort exams by date
    return exams.firstWhereOrNull(
      (exam) => exam.examDate.isAfter(now),
    ); // Get the first upcoming exam
  }

  @override
  void initState() {
    super.initState();
    if (widget.exams.isNotEmpty) {
      upcomingExam = _findUpcomingExam(widget.exams);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(22),
          child: TimerCountdown(
            timeTextStyle: Theme.of(context).textTheme.headlineSmall,
            endTime: upcomingExam?.examDate ?? DateTime.now(),
            onEnd: () {},
          ),
        ),
      ),
    ]);
  }
}
