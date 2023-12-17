import 'dart:convert';
import 'dart:typed_data';

import 'package:academia/constants/common.dart';
import 'package:academia/controllers/settings_controller.dart';
import 'package:academia/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ExamTimeTablePage extends StatelessWidget {
  const ExamTimeTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    var settingsController = Get.find<SettingsController>();
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
            child: Column(
              children: [
                Container(
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
                            DateTime.now().hour < 11
                                ? "Good Morning"
                                : DateTime.now().hour < 13
                                    ? "Good Afternoon"
                                    : "Good Evening",
                            style: normal.copyWith(
                              color: Theme.of(context).primaryColorLight,
                            ),
                          ),
                          Text(
                            (user.name!.split(" ")[0]).title().trim(),
                            style: h5.copyWith(
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
                            Get.to(const HomePage());
                          },
                          icon: const Icon(CupertinoIcons.house),
                        ),
                      )
                    ],
                  ),
                ),

                // The actual body
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 80,
                          child: TextField(
                            decoration: InputDecoration(
                                hintText: "Units",
                                suffix: IconButton(
                                    onPressed: () {},
                                    icon: Icon(CupertinoIcons.search_circle_fill))),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        tooltip: "Add a unit",
        backgroundColor: Theme.of(context).primaryColorDark,
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }
}
