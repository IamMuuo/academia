import 'package:academia/models/user.dart';
import 'package:academia/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class LoginController extends GetxController {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  User newUser = User();
  var acceptTerms = false.obs;
  var showPassword = false.obs;
  var isloading = false.obs;

  Future<void> login() async {
    isloading.value = true;
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        "Form Error",
        "Please ensure you fill in the form to continue",
        backgroundColor: Colors.white,
        icon: const Icon(
          CupertinoIcons.xmark_circle,
          color: Colors.red,
        ),
      );
      isloading.value = false;
      return;
    }

    // validate accepts T&C
    if (!acceptTerms.value) {
      Get.snackbar(
        "Terms and Conditions",
        "You must agree the terms and conditions to continue to the applications",
        backgroundColor: Colors.white,
        icon: const Icon(
          CupertinoIcons.xmark_circle,
          color: Colors.red,
        ),
      );
      isloading.value = false;
      return;
    }

    // auth the user
    bool authenticated = await newUser.login(
        usernameController.text.trim(), passwordController.text.trim());

    if (authenticated) {
      newUser = await newUser.getUserDetails(
          usernameController.text, passwordController.text);

      // store the user
      var appDB = await Hive.openBox("appDB");
      appDB.put("user", newUser);
      isloading.value = false;
      // Get.off(const HomePage());
      return;
    } else {
      Get.snackbar(
        "Form Validation Error",
        "Login failure, Please check your admno and password",
        backgroundColor: Colors.white,
        icon: const Icon(
          CupertinoIcons.xmark_circle,
          color: Colors.red,
        ),
      );
      isloading.value = false;
    }
  }
}
