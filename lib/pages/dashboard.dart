import 'package:academia/constants/common.dart';
import 'package:academia/controllers/dashboard_controller.dart';
import 'package:academia/widgets/academia_app_bar.dart';
import 'package:flutter/material.dart';
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
            // Header
            AcademiaAppBar(
              title: "Hi, ${(user.name!.split(" ")[0]).title().trim()}",
              subtitle:
                  "It's ${DateFormat.yMMMMEEEEd().format(DateTime.now())}",
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
