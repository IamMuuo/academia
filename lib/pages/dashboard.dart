import 'dart:convert';
import 'dart:typed_data';
import 'package:academia/constants/common.dart';
import 'package:academia/controllers/dashboard_controller.dart';
import 'package:academia/controllers/settings_controller.dart';
import 'package:academia/pages/time_line_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final DashboardController dashBoardController =
        Get.put(DashboardController());
    final settingsController = Get.find<SettingsController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColorDark,
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      child: Obx(
                        () => ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(800),
                          ),
                          child: settingsController.showProfilePic.value
                              ? Image.memory(
                                  Uint8List.fromList(
                                    base64Decode(user.profile!.replaceFirst(
                                        "data:image/gif;base64,", "")),
                                  ),
                                  fit: BoxFit.cover,
                                  width: 400,
                                  height: 400,
                                )
                              : Image.asset(
                                  user.gender == "male"
                                      ? "assets/images/male_student.png"
                                      : "assets/images/female_student.png",
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hi, ${(user.name!.split(" ")[0]).title().trim()}",
                          style: normal.copyWith(
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                        Text(
                          "It's ${DateFormat.yMMMMEEEEd().format(DateTime.now())}",
                          style: h6.copyWith(
                            color: Theme.of(context).primaryColorLight,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColorLight,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                      ),
                      child: IconButton(
                        tooltip: "Back to home",
                        onPressed: () {
                          Get.to(const TimeLinePage());
                        },
                        icon: const Icon(Icons.timeline),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // body
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Classes Today
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      // color: Theme.of(context).primaryColorLight,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(16),
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
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Schedules today
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      // color: Theme.of(context).primaryColorLight,
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(16),
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
                              "assets/images/schedule.png",
                              fit: BoxFit.scaleDown,
                              height: 50,
                              width: 50,
                            ),
                          ),
                        ),
                        const Text(
                          "0",
                          style: h3,
                        ),
                        Text(
                          "Events and Schedules",
                          style: normal.copyWith(
                            color: Theme.of(context).primaryColorLight,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
