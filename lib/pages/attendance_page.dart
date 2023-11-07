import 'package:academia/controllers/courses_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  bool isLoading = false;
  late CoursesPageController controller;

  @override
  void initState() {
    controller = Get.find<CoursesPageController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Class Attendance"),
      ),
      body: controller.hasProgress.value
          ? Padding(
              padding: const EdgeInsets.all(2),
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 2,
                crossAxisSpacing: 2,
                children: controller.buildProgressCards(),
              ),
            )
          : const Center(
              child: Text("Seems you have no course progress"),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          await controller.updateProgress();
          setState(() {
            isLoading = false;
          });
        },
        child: isLoading
            ? LoadingAnimationWidget.horizontalRotatingDots(
                color: Colors.white, size: 20)
            : const Icon(Icons.refresh),
      ),
    );
  }
}
