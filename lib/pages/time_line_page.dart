import 'dart:io';
import 'package:academia/controllers/notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class TimeLinePage extends StatelessWidget {
  const TimeLinePage({super.key});

  Widget buildEventsWidget() {
    return const Placeholder();
  }

  @override
  Widget build(BuildContext context) {
    NotificationsController controller = Get.put(NotificationsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Semester Timeline"),
        actions: [
          IconButton(
              onPressed: () async {
                // await controller.fetchAcademicCalendar();
                sleep(const Duration(seconds: 10));
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: LiquidPullToRefresh(
        onRefresh: () async {
          await controller.fetchAcademicCalendar();
        },
        height: 200,
        child: controller.events.isEmpty
            ? SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/girl_sitted.png",
                        height: 200,
                      ),
                      const Text(
                        "Darn you got us but we are working to provide your semester's timeline",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            : buildEventsWidget(),
      ),
    );
  }
}
