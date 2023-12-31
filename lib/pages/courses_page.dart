import 'package:academia/constants/common.dart';
import 'package:academia/controllers/courses_page_controller.dart';
import 'package:academia/controllers/dashboard_controller.dart';
import 'package:academia/pages/attendance_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var dashBoardController = Get.find<DashboardController>();
    var controller = Get.put(CoursesPageController());
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Courses",
        ),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        height: 200,
        onRefresh: () async {
          await controller.updateCourses();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Classes today
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(90),
                              ),
                              child: CircleAvatar(
                                radius: 40,
                                child: Image.asset(
                                  "assets/images/abc.png",
                                  fit: BoxFit.scaleDown,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ),
                            Text(
                              "${dashBoardController.classesToday}",
                              style: h3,
                            ),
                            Text(
                              "Classes today",
                              style: normal.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Classes Remaining
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8),
                          ),
                          border:
                              Border.all(color: Theme.of(context).primaryColor),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(90),
                              ),
                              child: CircleAvatar(
                                radius: 40,
                                child: Image.asset(
                                  "assets/images/holding_back.png",
                                  fit: BoxFit.scaleDown,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ),
                            Text(
                              "${controller.numOfClasses}",
                              style: h3,
                            ),
                            Text(
                              "Classes weekly",
                              style: normal.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  width: MediaQuery.of(context).size.width * 0.93,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    border: Border.all(color: Theme.of(context).primaryColor),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Of",
                        style: h2,
                      ),
                      Text.rich(TextSpan(text: "today's\n", children: [
                        TextSpan(
                          text: "${dashBoardController.classesToday}",
                          style: h3,
                        ),
                        TextSpan(
                          text: "\nYou have completed",
                        ),
                      ]))
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.to(const AttendancePage());
                        },
                        icon: const Icon(Icons.check_circle_rounded),
                        label: const Text("View Attendance"),
                      ),
                      const Spacer(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
