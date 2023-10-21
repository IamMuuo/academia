import 'package:academia/constants/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToolPageController extends GetxController {
  Future<void> fetchToken() async {
    var token = await magnet.fetchCateringToken();
    await Get.defaultDialog(
      title: "Your Token",
      content: Text("Your Token is ${token['message'] ?? ''}"),
    );
  }
}
