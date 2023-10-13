import 'package:academia/constants/common.dart';
import 'package:academia/models/user.dart';
import 'package:get/get.dart';

class ProfilePageController extends GetxController {
  var currentUser = User().obs;

  ProfilePageController() {
    currentUser.value = user;
  }

  // fetch user details
  Future<void> refreshUserDetails() async {
    await user.getUserDetails(user.admno!, user.password!);
    currentUser.value = await appDB.get("user");
  }
}
