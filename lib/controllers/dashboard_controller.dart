import 'package:academia/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  TextEditingController searchBoxController = TextEditingController();

  void getNotifications() {
    getUserDetails("21-2080", "Demo802sy\$");
    Get.snackbar(
      "Internal Error",
      "Feature Coming soon",
      icon: const Icon(CupertinoIcons.ant_circle),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
    );
  }
}
