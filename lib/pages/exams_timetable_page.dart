import 'dart:convert';
import 'dart:typed_data';

import 'package:academia/constants/common.dart';
import 'package:academia/controllers/settings_controller.dart';
import 'package:academia/pages/home_page.dart';
import 'package:academia/widgets/caurosel_item_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
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
                const SizedBox(height: 16),

                FlutterCarousel(
                  items: [
                    Container(
                      color: Colors.red,
                    )
                  ],
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                )
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
                          height: 60,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "BIL 112, MATH 120, ..",
                              label: const Text("Please input units to find"),
                              suffix: IconButton(
                                onPressed: () {},
                                icon: Icon(CupertinoIcons.search_circle_fill),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 8, right: 8),
                            child: Column(
                              children: [
                                Image.asset("assets/images/view.png",
                                    width: 200),
                                const Text(
                                    "Input your units and let us do the heavy lifting")
                              ],
                            )),
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
