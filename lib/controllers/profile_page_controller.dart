import 'package:academia/constants/common.dart';
import 'package:academia/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class ProfilePageController extends GetxController {
  Box? _dbBox;
  User? user;

  ProfilePageController() {
    openBox();
    user = getUserFromDB();
  }

  Future<void> openBox() async {
    _dbBox = await Hive.openBox(dbName);
  }

  User getUserFromDB() {
    if (_dbBox != null) {
      return _dbBox!.get("user");
    }
    debugPrint("Error: could not load user details from local storage");
    return User();
  }
}
