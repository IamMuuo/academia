import 'package:academia/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Your Courses',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your courses',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(CupertinoIcons.ellipsis)
                      ],
                    ),
                    Image.asset(
                      "assets/images/graduating.png",
                      height: 250,
                      width: 250,
                    ),
                    Text(
                      'August 2100 semester',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Couresel

            // course cards
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                child: ListView(
                  children: [
                    CourseCard(),
                    CourseCard(),
                    CourseCard(),
                    CourseCard(),
                    CourseCard(),
                    CourseCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
