import 'dart:convert';
import 'dart:typed_data';

import 'package:academia/constants/common.dart';
import 'package:academia/controllers/exams_timetable_controller.dart';
import 'package:academia/controllers/settings_controller.dart';
import 'package:academia/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';

class ExamTimeTablePage extends StatelessWidget {
  const ExamTimeTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    var settingsController = Get.find<SettingsController>();
    var controller = Get.put(ExamsTimeTableController());
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
                            "Are you ready ${(user.name!.split(" ")[0]).title().trim()}?",
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
                  items: buildCauroselItems(context, hasExams: false),
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.25,
                    autoPlayCurve: Curves.easeInSine,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    indicatorMargin: 2,
                    slideIndicator: CircularSlideIndicator(
                      itemSpacing: 12,
                      indicatorBorderColor: Theme.of(context).primaryColorDark,
                      indicatorRadius: 5,
                      // indicatorBackgroundColor: Colors.red,
                    ),
                  ),
                ),

                buildContentCards(context),
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
                          padding:
                              const EdgeInsets.only(top: 20, left: 8, right: 8),
                          child: Column(
                            children: [
                              Image.asset("assets/images/view.png", width: 200),
                              const Text(
                                  "Input your units and let us do the heavy lifting")
                            ],
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

  // Method to add the caurosel
  List<Widget> buildCauroselItems(
    BuildContext context, {
    bool hasExams = false,
  }) {
    var items = <Widget>[];

    if (!hasExams) {
      items.add(
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                "assets/images/bot_sad.png",
                scale: 0.2,
                height: 120,
              ),
              Text(
                "It seems you have no upcoming exams",
                textAlign: TextAlign.center,
                style: normal.copyWith(
                  color: Theme.of(context).primaryColorLight,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );

      items.add(
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                "assets/images/bot_search.png",
                scale: 0.2,
                height: 120,
              ),
              Text(
                "Please tap on the + button to find and add",
                textAlign: TextAlign.center,
                style:
                    normal.copyWith(color: Theme.of(context).primaryColorLight),
              ),
            ],
          ),
        ),
      );
    }
    return items;
  }

  // build content cards
  Widget buildContentCards(BuildContext context, {bool hasExams = false}) {
    if (!hasExams) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Image.asset(
            "assets/images/view.png",
            height: 200,
          ),
          const SizedBox(
            height: 16,
          ),
          const Text("You are upto date, no exams for now"),
        ],
      );
    }
    return FlutterLogo();
  }
}
