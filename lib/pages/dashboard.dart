import 'dart:convert';
import 'dart:typed_data';

import 'package:academia/constants/common.dart';
import 'package:academia/controllers/dashboard_controller.dart';
import 'package:academia/controllers/settings_controller.dart';
import 'package:academia/pages/notifications_page.dart';
import 'package:flutter/cupertino.dart';
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
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Hi, ${(user.name!.split(" ")[0]).title()}!',
                              style: h4),
                          // Date
                          Text(
                            DateFormat.yMMMMEEEEd().format(DateTime.now()),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).primaryColor,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.to(
                            const NotificationPage(),
                            transition: Transition.upToDown,
                          );
                        },
                        tooltip: "Notifications",
                        icon: Icon(
                          CupertinoIcons.bell_fill,
                          color: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ),
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
                    width: 180,
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
                    width: 180,
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
