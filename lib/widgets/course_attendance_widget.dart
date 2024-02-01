import 'package:academia/exports/barrel.dart';

class CourseAttendanceCard extends StatelessWidget {
  const CourseAttendanceCard({
    super.key,
    required this.course,
    required this.percent,
  });
  final String course;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.38,
        maxWidth: MediaQuery.of(context).size.width * 0.4,
      ),
      child: CircularPercentIndicator(
        animation: true,
        animationDuration: 1000,
        radius: 50,
        percent: percent / 100,
        lineWidth: 20,
        progressColor: Theme.of(context).primaryColor,
        circularStrokeCap: CircularStrokeCap.round,
        center: Text(
          "$percent%",
          style: h6,
        ),
        footer: Text(
          course,
          style: h6.copyWith(
            fontSize: 10,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
