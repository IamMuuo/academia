import 'package:academia/constants/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:academia/widgets/caurosel_item_card.dart';

class DashboardController extends GetxController {
  TextEditingController searchBoxController = TextEditingController();

  void getNotifications() {
    debugPrint("${user.name}");
  }

  List<Widget> buildCauroselCards() {
    // debugPrint("Here");
    // List<Widget> cards = [];
    // if (appDB.containsKey("schedules") && appDB.get("schedules") != null) {
    //   debugPrint("inner");
    //   var schedules = appDB.get("schedules");
    //   for (Schedule schedule in schedules) {
    //     if (DateTime.parse(schedule.taskDate!)
    //         .isAfter(DateTime.now().add(const Duration(hours: 24)))) {
    //       cards.add(CauroselItemCard(
    //           title: schedule.taskName!,
    //           description: schedule.taskDescription!,
    //           location: "This task",
    //           date: schedule.taskDate!));
    //     } else {
    //       cards.add(CauroselItemCard(
    //           title: "You have no items",
    //           description:
    //               "Once you have an important event or schedule we will display it here",
    //           location: "How do I get started",
    //           date: "Report events not showing"));
    //     }
    //   }
    //   return cards;
    // }
    return <Widget>[
     const CauroselItemCard(
          icon1: Icons.quiz,
          icon2: CupertinoIcons.question_circle,
          title: "You have no items",
          description:
              "Once you have an important event or schedule we will display it here",
          location: "How do I get started",
          date: "Report events not showing")
    ];
  }
}
