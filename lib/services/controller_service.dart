import 'package:get/get.dart';
import 'package:flutter/material.dart';

/// ControllerService
/// A singleton class that perfoms actions on controllers
/// such as injecting controllers and various stuff to
/// the controllers
class ControllerService {
  static final ControllerService _controllerService =
      ControllerService._internal();

  factory ControllerService() {
    return _controllerService;
  }

  /// Method to inject a GetXController into the context
  /// Also returns the controller being injected
  GetxController injectController<T extends GetxController>(T controller,
      {bool permanent = true}) {
    Get.put(controller, permanent: permanent);
    return controller;
  }

  /// injectMultipleControllers
  /// Injects multiple controllers onto the context provided as a list of controllers
  ///
  /// Once injected, one can retrieve the controller using Get.find<T>() as
  /// per getx's documentation
  void injectMultipleControllers<T extends GetxController>(List<T> controllers,
      {bool permanent = true}) {
    for (var controller in controllers) {
      injectController(controller);
    }
    debugPrint("${controllers.length} controllers injected successfully");
  }

  ControllerService._internal();
}
