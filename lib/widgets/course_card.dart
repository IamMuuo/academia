import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({
    super.key,
    /*
    required this.courseName,
    this.icon,
    this.courseTime,
    */
  });
  // final icon;
  // final String? courseName;
  // final String? courseTime;
  //
  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
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
                  padding: EdgeInsets.all(12),
                  enableFeedback: true,
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.heart_fill,
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'ACS 211',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // subtitle
                    Text(
                      'Today at 2:00pm',
                      style: TextStyle(
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
              icon: Icon(CupertinoIcons.arrow_right),
            ),
          ],
        ),
      ),
    );
  }
}
