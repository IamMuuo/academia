import 'package:academia/constants/common.dart';
import 'package:academia/controllers/dashboard_controller.dart';
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
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
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.bell_fill,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Search bar
            Container(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: dashBoardController.searchBoxController,
                decoration: InputDecoration(
                  filled: true,
                  suffixIcon: IconButton(
                    padding: const EdgeInsets.all(16),
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.search,
                      size: 30,
                    ),
                  ),
                  hintText: 'Looking for something?',
                  hintStyle: const TextStyle(),
                ),
              ),
            ),
            //

            FlutterCarousel(
              items: dashBoardController.buildCauroselCards(),
              // [
              //   CauroselItemCard(
              //     date: "Sunday 14, January, 2023",
              //     title: "Task 1",
              //     description: "Test task",
              //     location: "Everywhere",
              //     center: Image.asset(
              //       "assets/images/smiley.png",
              //       height: 100,
              //     ),
              //   ),
              // ],
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.25,
                showIndicator: true,
                autoPlay: true,
                enlargeCenterPage: true,
                slideIndicator: CircularWaveSlideIndicator(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Courses you're enrolled to",
                        style: h5,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              height: 100, width: 180, color: Colors.black),
                          Container(
                              height: 100, width: 180, color: Colors.green)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(height: 100, width: 180, color: Colors.red),
                          Container(
                              height: 100, width: 180, color: Colors.purple)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              height: 100, width: 180, color: Colors.teal),
                          Container(
                              height: 100, width: 180, color: Colors.black)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
