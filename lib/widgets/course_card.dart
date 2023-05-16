import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({
    super.key,
    required this.icon,
    required this.courseName,
    required this.courseTime,
  });

  final IconData icon;
  final String courseName;
  final String courseTime;

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  padding: const EdgeInsets.all(12),
                  enableFeedback: true,
                  onPressed: () {},
                  icon: Icon(widget.icon),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      widget.courseName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // subtitle
                    Text(
                      widget.courseTime,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.arrow_right),
            ),
          ],
        ),
      ),
    );
  }
}

// This method is supposed to build
// the user's courses from the api
// never create a single course card instance
// without this method

List<CourseCard> buildCourseCards() {
  final courses = <CourseCard>[];
  courses.add(const CourseCard(
    icon: CupertinoIcons.circle,
    courseName: "MSB 101",
    courseTime: "Today 11:00pm",
  ));

  courses.add(const CourseCard(
    icon: CupertinoIcons.circle,
    courseName: "MATH 121",
    courseTime: "Today 11:00pm",
  ));

  courses.add(const CourseCard(
    icon: CupertinoIcons.circle,
    courseName: "ENG 101",
    courseTime: "Tommorow 11:00pm",
  ));

  courses.add(const CourseCard(
    icon: CupertinoIcons.circle,
    courseName: "PHY 217",
    courseTime: "Thur 11:00pm",
  ));

  courses.add(const CourseCard(
    icon: CupertinoIcons.circle,
    courseName: "BIO 111",
    courseTime: "Tommorow 3:00pm",
  ));

  courses.add(const CourseCard(
    icon: CupertinoIcons.circle,
    courseName: "PHIL 111",
    courseTime: "Sat 12:00pm",
  ));
  return courses;
}
