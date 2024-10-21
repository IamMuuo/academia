import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_onConnectionChanged);
  }

  void _onConnectionChanged(List<ConnectivityResult> result) {
    if (result.contains(ConnectivityResult.none)) {
      Get.rawSnackbar(
        messageText: const Text(
          "You are not connected to the internet some features might not work",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        snackPosition: SnackPosition.TOP,
        isDismissible: false,
        duration: const Duration(seconds: 5),
        backgroundColor: Colors.red[400]!,
        icon: const Icon(Ionicons.cloud_offline_outline, color: Colors.white),
      );
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
        Get.rawSnackbar(
          messageText: const Text(
            "Your connection is back",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          duration: const Duration(seconds: 5),
          isDismissible: false,
          backgroundColor: Colors.green[400]!,
          icon: const Icon(Ionicons.cloud_done_outline, color: Colors.white),
        );
      }
    }
  }
}
