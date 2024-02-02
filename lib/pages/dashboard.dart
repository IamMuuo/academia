import 'package:academia/constants/common.dart';
import 'package:academia/controllers/dashboard_controller.dart';
import 'package:academia/controllers/settings_controller.dart';
import 'package:academia/widgets/academia_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    final DashboardController dashBoardController =
        Get.put(DashboardController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            // Header
            AcademiaAppBar(
              title: "Hi, ${(user.name!.split(" ")[0]).title().trim()}",
              subtitle:
                  "It's ${DateFormat.yMMMMEEEEd().format(DateTime.now())}",
            ),
            // body
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: FlutterCarousel(
                items: [
                  // Day Percent
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircularPercentIndicator(
                          radius: 60,
                          center: Text(
                            "${(dashBoardController.daypercent * 100).floor()}%",
                            style: h5,
                          ),
                          percent: dashBoardController.daypercent,
                          lineWidth: 20,
                          progressColor: Theme.of(context).primaryColorDark,
                          animationDuration: 2000,
                          animation: true,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: "The day is\n",
                              style: h5.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "${(dashBoardController.daypercent * 100).floor()}%",
                              style: h3,
                            ),
                            const TextSpan(text: "\nGone\n", style: h6),
                            TextSpan(
                                text: dashBoardController.getDayPercentQuote,
                                style: normal.copyWith(fontSize: 12))
                          ]),
                        ),
                      ],
                    ),
                  ),

                  // Week percent
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircularPercentIndicator(
                          radius: 60,
                          center: Text(
                            "${(dashBoardController.weekPercent * 100).floor()}%",
                            style: h5,
                          ),
                          percent: dashBoardController.weekPercent,
                          lineWidth: 20,
                          progressColor: Theme.of(context).primaryColorDark,
                          animationDuration: 2000,
                          animation: true,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: "The week is\n",
                              style: h5.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "${(dashBoardController.weekPercent * 100).floor()}%",
                              style: h3,
                            ),
                            const TextSpan(text: "\nVanished\n", style: h6),
                            TextSpan(
                                text: dashBoardController.getWeekPercentQuote,
                                style: normal.copyWith(fontSize: 12))
                          ]),
                        ),
                      ],
                    ),
                  ),
                  //
                  // // Semester
                  Container(
                    padding: const EdgeInsets.all(12),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircularPercentIndicator(
                          radius: 60,
                          center: Text(
                            "${(dashBoardController.semesterPercent * 100).floor()}%",
                            style: h5,
                          ),
                          percent: dashBoardController.semesterPercent,
                          lineWidth: 20,
                          progressColor: Theme.of(context).primaryColorDark,
                          animationDuration: 2000,
                          animation: true,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: "The semester is\n",
                              style: h6.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "${(dashBoardController.semesterPercent * 100).floor()}%",
                              style: h3,
                            ),
                            const TextSpan(text: "\nGone!\n", style: h6),
                            TextSpan(
                                text:
                                    dashBoardController.getSemesterPercentQuote,
                                style: normal.copyWith(fontSize: 12))
                          ]),
                        ),
                      ],
                    ),
                  ),
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  height: MediaQuery.of(context).size.height * 0.25,
                  enlargeCenterPage: true,
                  slideIndicator: CircularSlideIndicator(
                    indicatorRadius: 6,
                    itemSpacing: 12,
                    indicatorBackgroundColor:
                        Theme.of(context).primaryColorDark,
                  ),
                ),
              ),
            ),
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
                          "${dashBoardController.classesTodayCount}",
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
                        Text(
                          "${dashBoardController.numberofTasks}",
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

            const SizedBox(
              height: 12,
            ),
            SizedBox(
              // height: 400,
              child: Column(
                children: [
                  const Text(
                    "Today's activities and classes",
                    style: h6,
                  ),
                  dashBoardController.classesTodayCount == 0
                      ? Column(
                          children: [
                            Image.asset("assets/images/chill.png"),
                            const Text(
                              "You have no classes today take the day off, maybe visit the library",
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )
                      : SizedBox(
                          height: 120,
                          child: ListView.builder(
                            itemCount: dashBoardController.classesToday.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12))),
                                  child: ListTile(
                                    leading: const Icon(CupertinoIcons.timer),
                                    title: Text(dashBoardController
                                        .classesToday[index].name!),
                                    // tileColor:
                                    // Theme.of(context).primaryColorDark,
                                    subtitle: Text(
                                      "${dashBoardController.classesToday[index].name!} will be in ${dashBoardController.classesToday[index].room}, between ${dashBoardController.classesToday[index].period}, and will be taught by ${dashBoardController.classesToday[index].lecturer}",
                                    ),
                                    // titleTextStyle: normal,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 12),
                  const Text("Upcoming events and classes", style: h6),
                  SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dashBoardController.classesTommorrow.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(12),
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(12)),
                                  color: Theme.of(context).primaryColorDark),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        Theme.of(context).primaryColorLight,
                                    child: const Icon(CupertinoIcons.timer),
                                  ),
                                  Text(
                                    dashBoardController
                                        .classesTommorrow[index].name!,
                                    style: normal.copyWith(
                                        color: Theme.of(context)
                                            .primaryColorLight),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
