import 'package:academia/controllers/courses_page_controller.dart';
import 'package:academia/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CoursesPageController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Courses",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await controller.updateCourses();
              },
              icon: const Icon(Icons.password))
        ],
      ),
      body: LiquidPullToRefresh(
        height: 200,
        onRefresh: () async {
          return controller.updateCourses();
        },
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: FlutterCarousel(
                items: controller.buildTimeTableCourses(),
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.2,
                  autoPlay: true,
                  showIndicator: false,
                  enlargeCenterPage: true,
                ),
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
      ),
    );
  }
}
