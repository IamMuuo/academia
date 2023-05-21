import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  TextEditingController searchBoxController = TextEditingController();

  void getNotifications() {
    Get.snackbar(
      "Internal Error",
      "Feature Coming soon",
      icon: Icon(CupertinoIcons.ant_circle),
      snackPosition: SnackPosition.TOP,
    );
  }
}
