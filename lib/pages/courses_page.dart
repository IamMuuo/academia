import 'package:academia/controllers/courses_page_controller.dart';
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
      ),
      body: LiquidPullToRefresh(
        height: 200,
        onRefresh: () async {
          await controller.updateCourses();
        },
        child: ListView(
          children: [
            Obx(
              () => controller.hasCourses.value
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 10),
                      child: FlutterCarousel(
                        items: controller.buildElements(),
                        options: CarouselOptions(
                          height: MediaQuery.of(context).size.height * 0.2,
                          autoPlay: true,
                          showIndicator: false,
                          enlargeCenterPage: true,
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 200,
                      child: Image.asset("assets/images/bot_sad.png"),
                    ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Align(
                alignment: Alignment.center,
                child: Text("My Class Attendance"),
              ),
            ),
            // Obx(
            //   () => controller.hasTimetable.value
            //       ? SizedBox(
            //           width: MediaQuery.of(context).size.width,
            //           child: SingleChildScrollView(
            //             scrollDirection: Axis.horizontal,
            //             child: DataTable(
            //               columnSpacing: 10,
            //               columns: controller.buildDataColumn(),
            //               rows: controller.buildDataRow(),
            //             ),
            //           ),
            //         )
            //       : const Center(
            //           child: Text(
            //               "No  units found, please pull to refresh, if the problem persists please relaunch the app!"),
            //         ),
            // )
          ],
        ),
      ),
    );
  }
}
