import 'package:academia/constants/common.dart';
import 'package:academia/controllers/dashboard_controller.dart';
import 'package:academia/widgets/caurosel_item_card.dart';
import 'package:academia/widgets/course_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academia/widgets/emojicon.dart';
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
      body: SafeArea(
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
                        Text(
                          'Hi, ${user.name!.split(" ")[0]}!',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Date
                        Text(
                          DateFormat.yMMMMEEEEd().format(DateTime.now()),
                          style: TextStyle(
                            color: Colors.grey[300],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: IconButton(
                        onPressed: () {
                          dashBoardController.getNotifications();
                        },
                        icon: const Icon(
                          CupertinoIcons.bell_fill,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            // Search bar
            Container(
              padding: const EdgeInsets.only(
                right: 16,
                left: 16,
              ),
              child: TextField(
                controller: dashBoardController.searchBoxController,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blue[400],
                  suffixIcon: IconButton(
                    padding: const EdgeInsets.all(16),
                    onPressed: () {},
                    icon: const Icon(
                      CupertinoIcons.search,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  hintText: 'Looking for something?',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),

            // mood text
            const Text(
              "How are you currently feeling?",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buildEmojiCons(),
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),

            // Courses you are taking

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                  left: 12,
                  right: 12,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Your school life at glance',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
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
                        // padEnds: false,
                        height: MediaQuery.of(context).size.height * 0.3,
                        showIndicator: true,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        slideIndicator: CircularWaveSlideIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
