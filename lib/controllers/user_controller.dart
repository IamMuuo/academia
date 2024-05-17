///  # UserController
///  Author: Erick
///  File: Defines a controller that manages user info state across the application

import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:academia/models/models.dart';

class UserController extends GetxController {
  Rx<User?> user = Rxn<User>();
  Rx<bool> isLoggedIn = false.obs;

  @override

  /// Load the user from disk and initialize the controller
  Future<void> onInit() async {
    super.onInit();
    final loadedUser = await loadUserFromDisk();

    if (loadedUser != null) {
      user.value = loadedUser;
      isLoggedIn.value = true;
    }
  }

  Future<User?> loadUserFromDisk() async {
    // load the user from local storage
    final storedUsers = await UserModelHelper().queryAll();

    if (storedUsers.isNotEmpty) {
      user.value = User.fromJson(storedUsers[0]);

      // initialize magnet
      magnet = Magnet(user.value!.regno!, user.value!.password!);
      return user.value;
    }
    return null;
  }

  /// Perform a request to login a user
  Future<bool> login(String username, String password) async {
    // Make API request to authenticate user
    try {
      magnet = Magnet(username, password);
      return await magnet.login();
    } catch (error) {
      // Handle magnet exceptions
      rethrow;
    }
  }

  /// Retrieves user details from magnet and stores it on disk
  Future<void> getUserDetails(String username, String password) async {
    try {
      final rawdata = await magnet.fetchUserData();

      final data = <String, dynamic>{};

      rawdata.forEach((key, value) {
        if (key is String) {
          data[key] = rawdata[key];
        }
      });

      user.value = User.fromJson(data);
      user.value!.password = password;

      await UserModelHelper().create(user.value!.toJson());
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      rethrow;
    }
  }

  /// Logout a user
  Future<void> logout() async {
    try {
      // Close the Hive box
      // await appDB.close();
      // Delete the Hive box directory to remove all data
      // await Hive.deleteBoxFromDisk(dbName);
      Get.reloadAll(); // Clear all the controllers
    } catch (e) {
      debugPrint("Error during logout: ${e.toString()}");
    }
  }
}
