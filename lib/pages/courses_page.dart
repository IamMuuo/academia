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
        ),
        centerTitle: true,
      ),
      body: LiquidPullToRefresh(
        height: 200,
        onRefresh: () async {
          await controller.updateCourses();
        },
        child: SingleChildScrollView(
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
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Text("My Class Attendance"),
                ),
              ),
              Obx(
                () => SizedBox(
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: controller.hasProgress.value
                        ? GridView.count(
                            crossAxisCount: 2,
                            padding: const EdgeInsets.all(5),
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                            children: controller.buildProgressCards(),
                          )
                        : Image.asset("assets/images/bot_sad.png")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
