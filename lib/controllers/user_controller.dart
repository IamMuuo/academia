import 'package:academia/exports/barrel.dart';
import 'package:academia/services/services.dart';
import 'package:get/get.dart';

///  # UserController
///  Author: Erick
///  File: Defines a controller that manages user info state across the application

class UserController extends GetxController {
  Rx<User?> user = Rxn<User>();
  Rx<bool> isLoggedIn = false.obs;

  @override

  /// Load the user from disk and initialize the controller
  void onInit() {
    // load the user from local storage
    if (StorageService().appDB.containsKey("user")) {
      user.value = StorageService().appDB.get("user");
      isLoggedIn.value = true;
      magnet = Magnet(user.value!.admno!, user.value!.password!);
    }
    super.onInit();
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
      var data = await magnet.fetchUserData();
      user.value = User.fromJson(data);
      user.value!.password = password;
      await StorageService().appDB.put("user", user.value);
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
  }

  /// Logout a user
  Future<void> logout() async {
    try {
      // Close the Hive box
      // await appDB.close();
      await StorageService().appDB.deleteAll(["user"]);
      // Delete the Hive box directory to remove all data
      // await Hive.deleteBoxFromDisk(dbName);
      Get.reloadAll(); // Clear all the controllers
    } catch (e) {
      debugPrint("Error during logout: ${e.toString()}");
    }
  }
}
