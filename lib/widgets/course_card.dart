import 'package:academia/exports/barrel.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.courseTitle,
    required this.dayOfWeek,
    required this.period,
    required this.venue,
    required this.lecturer,
    required this.campus,
    this.icon = const Icon(Icons.school_sharp),
    this.backGround = Colors.white,
    this.borderColor = Colors.grey,
    this.keyStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
    this.valueStyle = const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    ),
    this.titleColor = Colors.white,
  });
  final String courseTitle;
  final String dayOfWeek;
  final String period;
  final String campus;
  final String venue;
  final String lecturer;
  final Color backGround;
  final Color borderColor;
  final Color titleColor;
  final TextStyle valueStyle;
  final TextStyle keyStyle;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backGround,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 2,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      constraints: const BoxConstraints(minHeight: 150),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // header
          Row(
            children: [
              icon,
              const Spacer(),
              Text(
                courseTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: titleColor,
                ),
              ),
            ],
          ),

          // Date and time
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Every : ",
                      style: keyStyle,
                    ),
                    TextSpan(
                      text: dayOfWeek.title(),
                      style: valueStyle,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Period : ",
                      style: keyStyle,
                    ),
                    TextSpan(
                      text: period,
                      style: valueStyle,
                    ),
                  ],
                ),
              )
            ],
          ),
          // Venues
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Campus: ",
                      style: keyStyle,
                    ),
                    TextSpan(
                      text: campus,
                      style: valueStyle,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Venue: ",
                      style: keyStyle,
                    ),
                    TextSpan(
                      text: venue,
                      style: valueStyle,
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Lecturer: ",
                      style: keyStyle,
                    ),
                    TextSpan(
                      text: lecturer,
                      style: valueStyle,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
