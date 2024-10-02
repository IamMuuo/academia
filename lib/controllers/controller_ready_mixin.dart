import 'dart:async';
import 'package:get/get.dart';

mixin ReadyMixin on GetxController {
  final isControllerReady = false.obs;
  FutureOr<void> initController();
  FutureOr<void> controllerReady() {}

  @override
  void onInit() async {
    await initController();
    super.onInit();
  }

  @override
  void onReady() async {
    await controllerReady();
    super.onReady();
    isControllerReady.value = true;
  }
}
