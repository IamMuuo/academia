import 'package:academia/widgets/course_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Courses",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          FlutterCarousel(
            items: const [
              CourseCard(
                courseTitle: "ACS 113",
                period: "08:00 AM - 13:00PM",
                venue: "Power Lab",
                lecturer: "James Bond",
                campus: "Athi",
                dayOfWeek: "Monday",
                icon: Icon(
                  CupertinoIcons.paw,
                  color: Colors.green,
                ),
              )
            ],
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.2,
              autoPlay: true,
              slideIndicator: CircularWaveSlideIndicator(
                currentIndicatorColor: Colors.blue,
                indicatorBackgroundColor: Colors.blue[200],
              ),
              enlargeCenterPage: true,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Align(
              alignment: Alignment.center,
              child: Text("Browse all available courses"),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                children: const [
                  CourseCard(
                    courseTitle: "ACS 113",
                    period: "08:00 AM - 13:00PM",
                    venue: "Power Lab",
                    lecturer: "James Bond",
                    campus: "Athi",
                    dayOfWeek: "Monday",
                  ),
                  CourseCard(
                    courseTitle: "ACS 113",
                    period: "08:00 AM - 13:00PM",
                    venue: "Power Lab",
                    lecturer: "James Bond",
                    campus: "Athi",
                    dayOfWeek: "Tuesday",
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
