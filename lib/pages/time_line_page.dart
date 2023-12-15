import 'dart:io';
import 'package:academia/constants/common.dart';
import 'package:academia/controllers/notifications_controller.dart';
import 'package:academia/widgets/semester_timeline_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:intl/intl.dart';

class TimeLinePage extends StatelessWidget {
  const TimeLinePage({super.key});

  Widget buildEventsWidget() {
    List<Widget> eventWidgets = <Widget>[];

    var events = appDB.get("academic_calendar");
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');

    for (var event in events) {
      eventWidgets.add(SemesterTimeLineTile(
          isFirst: event == events.first ? true : false,
          isLast: event == events.last ? true : false,
          isPast: inputFormat
                  .parse(event["stop"].toString().trim())
                  .isAfter(DateTime.now())
              ? false
              : true,
          title: event["name"],
          content:
              "${event['name'].toString().trim()} is sceduled between ${event['start'].toString().trim()} and ${event['stop'].toString().trim()}"));
    }
    return ListView(
      children: eventWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    NotificationsController controller = Get.put(NotificationsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Semester Timeline"),
        elevation: 0,
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
        child: controller.hasCalendar
            ? Center(
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: buildEventsWidget(),
              ),
      ),
    );
  }
}
