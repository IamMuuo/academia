import 'package:academia/exports/barrel.dart';
import 'package:academia/widgets/stat.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    final DashboardController dashBoardController =
        Get.put(DashboardController());

    final UserController userController = Get.find<UserController>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          children: [
            // Header
            AcademiaAppBar(
              title:
                  "Hi, ${(userController.user.value?.name ?? "user".split(" ")[0]).title().trim()}",
              subtitle:
                  "It's ${DateFormat.yMMMMEEEEd().format(DateTime.now())}",
            ),
            // body
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stat(
                    title: "Day",
                    percentage: dashBoardController.daypercent,
                  ),
                  Stat(
                    title: "Week",
                    percentage: dashBoardController.weekPercent,
                  ),
                  Stat(
                    title: "Semester",
                    percentage: dashBoardController.semesterPercent,
                  ),
                ],
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
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(width: 1),
                      // color: Theme.of(context).primaryColorLight,
                      color: Theme.of(context).colorScheme.surface,
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
                            )),
                        Obx(
                          () => userController.user.value!.name!.isEmpty
                              ? Text(
                                  dashBoardController.classesTodayCount
                                      .toString(),
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                )
                              : Text("Unregistered",
                                  style:
                                      Theme.of(context).textTheme.titleMedium),
                        ),
                        Text(
                          "Classes today",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),

                  // Schedules today
                  Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        border: Border.all(width: 1)),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
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
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          "Events and Schedules",
                          style: Theme.of(context).textTheme.titleMedium,
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
                  Text(
                    "Today's activities and classes",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
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
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.surface,
                                      borderRadius: const BorderRadius.all(
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
                  Text(
                    "Upcoming events and classes",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 120,
                    child: dashBoardController.classesTommorrow.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                dashBoardController.classesTommorrow.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(12),
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      color:
                                          Theme.of(context).primaryColorDark),
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
                          )
                        : SizedBox(
                            // height: 20,
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/images/having_coffee.png",
                                  height: 80,
                                ),
                                const Text(
                                  "Seems you have nothing upcoming for tommorrow take the day off, cool off",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
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
