///  # UserController
///  Author: Erick
///  File: Defines a controller that manages user info state across the application

import 'package:academia/exports/barrel.dart';
import 'package:academia/models/services/services.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';
import 'package:academia/models/models.dart';

class UserController extends GetxController {
  Rx<User?> user = Rxn<User>();
  Rx<bool> isLoggedIn = false.obs;
  final UserService service = UserService();

  @override

  /// Load the user from disk and initialize the controller
  Future<void> onInit() async {
    super.onInit();
    final loadedUser = await loadUserFromDisk();

    if (loadedUser != null) {
      user.value = loadedUser;
      final data = await login(
        user.value!.admissionNumber,
        user.value!.password,
      );

      data.fold((l) {
        Get.rawSnackbar(
          messageText: const Text(
            "Failed login",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          duration: const Duration(seconds: 5),
          isDismissible: false,
          backgroundColor: Colors.red[400]!,
          icon: const Icon(Ionicons.magnet, color: Colors.white),
        );
      }, (r) {});

      isLoggedIn.value = true;
    }
  }

  Future<User?> loadUserFromDisk() async {
    // load the user from local storage
    final storedUsers = await UserModelHelper().queryAll();

    if (storedUsers.isNotEmpty) {
      user.value = User.fromJson(storedUsers[0]);

      // initialize magnet
      magnet = Magnet(
        user.value!.admissionNumber,
        user.value!.password,
      );
      return user.value;
    }
    return null;
  }

  Future<Either<String, bool>> register(Map<String, dynamic> data) async {
    final newUser = User.fromMagnet(data);

    final result = await service.register(newUser.toJson());

    return result.fold((l) => left(l), (r) async {
      final res = await service.login(r.admissionNumber, data["password"]);
      return res.fold((l) => left(l), (r) {
        r.password = data["password"];
        user.value = r;
        isLoggedIn.value = true;
        UserModelHelper().create(user.value!.toJson());
        return right(true);
      });
    });
  }

  Future<Either<String, Map<String, dynamic>>> login(
      String admno, String password) async {
    /// Authenticate with magnet
    magnet = Magnet(admno, password);
    final result = await magnet.login();
    if (result.isLeft()) {
      return left(
        "Please check your admission number and password and try again",
      );
    }

    /// Check if student already exists on verisafe
    final isRegistered = await service.isStudentRegistered(admno);
    if (isRegistered.isRight()) {
      /// Fetch student details from verisafe
      final result = await service.login(admno, password);
      return result.fold((l) {
        return left(l);
      }, (r) {
        r.password = password;
        user.value = r;
        isLoggedIn.value = true;
        UserModelHelper().create(user.value!.toMap());
        return right(r.toJson());
      });
    }

    /// Fetch student details via magnet
    final res = await magnet.fetchUserDetails();
    if (res.isLeft()) {
      return left(
        "Please check your admission number and password and try again",
      );
    }

    // Return the data for registration
    return res.fold((l) => left(l.toString()), (r) => right(r));
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
