import 'package:flutter/material.dart';

class CourseCard extends StatefulWidget {
  const CourseCard({super.key});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.favorite,
            color: Colors.grey,
            size: 30,
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              // Course name
              Text(
                'ENG 098',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              Text(
                'Next class @ 10am BCC 3',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[600],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
