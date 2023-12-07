import 'dart:convert';
import 'dart:typed_data';

import 'package:academia/constants/common.dart';
import 'package:academia/controllers/dashboard_controller.dart';
import 'package:academia/controllers/settings_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
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
                        onPressed: () {},
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
          ], //
        ),
      ),
    );
  }
}
