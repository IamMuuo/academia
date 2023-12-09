import 'dart:convert';

import 'package:academia/constants/common.dart';
import 'package:academia/controllers/profile_page_controller.dart';
import 'package:academia/controllers/settings_controller.dart';
import 'package:academia/pages/settings_page.dart';
import 'package:academia/widgets/info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfilePageController());
    var settingsController = Get.find<SettingsController>();
    // controller.currentUser.value.gpa = 0.1;
    //controller.currentUser.value.name = "Erick";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(const SettingsPage());
            },
            icon: const Icon(Icons.settings_sharp),
          )
        ],
      ),
      body: LiquidPullToRefresh(
        height: 200,
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        onRefresh: () async {
          await controller.refreshUserDetails();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10,
            ),
            // profile pic
            Align(
              alignment: Alignment.center,
              child: Obx(
                () => Stack(
                  children: [
                    CircleAvatar(
                      radius: 60.0,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(800),
                        ),
                        child: settingsController.showProfilePic.value
                            ? Image.memory(
                                Uint8List.fromList(
                                  base64Decode(controller
                                      .currentUser.value.profile!
                                      .replaceFirst(
                                          "data:image/gif;base64,", "")),
                                ),
                              )
                            : Image.asset(user.gender == "male"
                                ? "assets/images/male_student.png"
                                : "assets/images/female_student.png"),
                      ),
                    ),
                    if (controller.currentUser.value.gpa! > 3.0)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            CupertinoIcons.checkmark_seal_fill,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),

            // name
            Container(
              padding: const EdgeInsets.only(top: 12, bottom: 3),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  controller.currentUser.value.name!.toString().title(),
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // Course
            Container(
              padding: const EdgeInsets.only(bottom: 12),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  controller.currentUser.value.programme!.title(),
                ),
              ),
            ),

            // school info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () => Text(
                                settingsController.showGPA.value
                                    ? controller.currentUser.value.gpa
                                        .toString()
                                    : "Hidden",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            const Text(
                              "GPA",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.currentUser.value.completedUnits
                                  .toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            const Text(
                              "Completed Units",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Colors.white,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Your Details",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),

                        // info cards
                        Expanded(
                          child: ListView(
                            children: [
                              // admno
                              InfoCard(
                                title: "Admission No",
                                content: controller.currentUser.value.admno!,
                                icon: CupertinoIcons.person_fill,
                              ),

                              // gender
                              InfoCard(
                                title: "Gender",
                                content: controller.currentUser.value.gender!
                                    .title(),
                                icon: CupertinoIcons.person_2_fill,
                              ),

                              // dob
                              InfoCard(
                                title: "Date Of Birth",
                                content:
                                    controller.currentUser.value.dateOfBirth!,
                                icon: CupertinoIcons.calendar,
                              ),
                              // address
                              InfoCard(
                                title: "Address",
                                content: controller.currentUser.value.address!,
                                icon: CupertinoIcons.envelope_fill,
                              ),
                              // email
                              InfoCard(
                                title: "Email",
                                content: controller.currentUser.value.email!,
                                icon: CupertinoIcons.envelope_fill,
                              ),
                              InfoCard(
                                title: "Academic Status",
                                content: controller.currentUser.value.status!
                                    .title(),
                                icon: CupertinoIcons.circle,
                              ),

                              // campus
                              InfoCard(
                                title: "Campus",
                                content: controller.currentUser.value.campus!
                                    .title(),
                                icon: CupertinoIcons.flag_fill,
                              ),

                              // fee Info
                              InfoCard(
                                title: "Amount Billed",
                                content:
                                    controller.currentUser.value.amountBilled!,
                                icon: CupertinoIcons.money_rubl_circle_fill,
                              ),
                              InfoCard(
                                title: "Fee Paid",
                                content:
                                    controller.currentUser.value.amountPaid!,
                                icon: CupertinoIcons.money_euro_circle,
                              ),
                              InfoCard(
                                title: "Fee Balance",
                                content: controller.currentUser.value.balance!,
                                icon: CupertinoIcons.money_euro_circle_fill,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
