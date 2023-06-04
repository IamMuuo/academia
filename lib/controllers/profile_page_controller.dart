import 'package:academia/constants/common.dart';
import 'package:academia/widgets/gpa_info_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:academia/widgets/info_card.dart';

class ProfilePageController extends GetxController {
  Widget buildInfoCards() {
    return ListView(
      children: [
        InfoCard(
            title: "Email", content: user.email!, icon: CupertinoIcons.mail),
      ],
    );
  }

  Widget buildGPACard() {
    MaterialColor color = Colors.red;

    if (user.gpa! > 3.5) {
      color = Colors.teal;
    } else if (user.gpa! > 3.0) {
      color = Colors.blue;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/icons/academia.png",
            height: 70,
            width: 70,
          ),
          GPAINFO(
            title: "GPA",
            icon: user.gpa! > 3.0
                ? CupertinoIcons.checkmark_seal_fill
                : CupertinoIcons.checkmark_seal,
            iconColor: color,
            content: "${user.gpa!}",
          ),
          GPAINFO(
            title: "Status",
            icon: CupertinoIcons.circle,
            iconColor: user.status == "Active" ? Colors.blue : Colors.red,
            content: user.status!,
          ),
        ],
      ),
    );
  }
}
