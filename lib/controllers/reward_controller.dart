import 'package:academia/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class RewardController extends GetxController {
  late User _user;
  RxInt vibePoints = 0.obs;
  final RxList<Reward> allPoints = <Reward>[].obs;

  @override
  void onInit() {
    super.onInit();
    UserModelHelper().queryAll().then((value) {
      if (value.isNotEmpty) {
        _user = User.fromJson(value.first);
        vibePoints.value = _user.vibePoints;
        return;
      } else {
        vibePoints.value = 0;
      }
    });
    debugPrint("[+] Rewards Loaded!");
    _awardPointsForDailyLaunch().then((value) {});
  }

  // Function to award daily app launch
  Future<void> _awardPointsForDailyLaunch() async {
    final now = DateTime.now();
    bool award = true;
    final userRewards = await RewardModelHelper().queryAll();
    userRewards.map((e) => Reward.fromJson(e)).toList().forEach((element) {
      if (element.awardedAt.day == now.day &&
          element.awardedAt.month == now.month &&
          element.awardedAt.year == now.year) {
        award = false;
      }
    });

    if (award) {
      awardPoints(2, "Daily app launch").then((value) {});
    }
  }

  Future<void> awardPoints(int points, String reason) async {
    final newReward = Reward(
      id: null,
      studentId: _user.id!,
      points: points,
      reason: reason,
      awardedAt: DateTime.now(),
    );
    await RewardModelHelper().create(newReward.toJson());

    // TODO make api call to store rewards
    allPoints.add(newReward);
    vibePoints.value += newReward.points;
    _user.vibePoints += newReward.points;

    HapticFeedback.mediumImpact().then((value) {
      Get.rawSnackbar(
        messageText: const Text(
          "Daily app launch reward",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: const Duration(seconds: 2),
        isDismissible: true,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[400]!,
        icon: const Icon(Ionicons.balloon_outline, color: Colors.white),
      );
    });

    // Store the user
    UserModelHelper().update(_user.toJson());
  }
}
