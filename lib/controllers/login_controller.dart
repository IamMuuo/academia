import 'dart:convert';
import 'package:academia/models/user.dart';
import 'package:academia/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:academia/constants/common.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var acceptTerms = false.obs;
  var showPassword = false.obs;
  var isloading = false.obs;

  Future<void> login() async {
    isloading.value = true;
    // Does the user conform to the T&C ?
    if (acceptTerms.isFalse) {
      Get.snackbar(
        "Terms Error",
        "Please accept the terms and conditions",
        icon: const Icon(
          CupertinoIcons.xmark_circle_fill,
          color: Colors.red,
        ),
        backgroundColor: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      isloading.value = false;
      return;
    }
    // Make API request to authenticate user
    try {
      final url = Uri.parse("$urlPrefix/login");
      final headers = {"Content-type": "application/json"};
      User newStudent = User()
        ..password = passwordController.text
        ..admno = usernameController.text;

      // Send a request
      final response = await post(
        url,
        headers: headers,
        body: json.encode(newStudent.toModel()),
      );

      debugPrint("Login status code: ${response.statusCode}");

      // Check response status
      if (response.statusCode == 200) {
        // Authentication successful
        // Process response and handle user authentication
        // Redirect to the home screen or perform other actions
        Get.snackbar(
          "Success",
          "Welcome, you've made it",
          icon: const Icon(
            CupertinoIcons.check_mark_circled_solid,
            color: Colors.green,
          ),
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        isloading.value = false;

        Get.off(const HomePage());
      } else {
        // Authentication failed
        // Display error message or perform other actions
        Get.snackbar(
          "Validation error",
          "Please checkout your username and password and try again",
          icon: const Icon(
            CupertinoIcons.xmark_circle_fill,
            color: Colors.red,
          ),
          backgroundColor: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        isloading.value = false;
      }
    } catch (error) {
      // Handle network or API errors
      isloading.value = false;
      debugPrint("Error during login: ${error.toString()}");
    }
  }
}
