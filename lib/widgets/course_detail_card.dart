import 'package:flutter/material.dart';

class CourseDetailCard extends StatefulWidget {
  const CourseDetailCard({super.key});

  @override
  State<CourseDetailCard> createState() => _CourseDetailCardState();
}

class _CourseDetailCardState extends State<CourseDetailCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(),
    );
  }
}
