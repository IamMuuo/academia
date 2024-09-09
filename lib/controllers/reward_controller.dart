import 'package:academia/controllers/user_controller.dart';
import 'package:academia/models/models.dart';
import 'package:academia/models/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dartz/dartz.dart';

class RewardController extends GetxController {
  RxInt vibePoints = 0.obs;
  final RxList<Reward> allPoints = <Reward>[].obs;
  final RewardsService service = RewardsService();

  final UserController _userController =
      Get.find<UserController>(); // Allow data sync

  @override
  void onInit() {
    super.onInit();
    loadRewards();
    debugPrint("[+] Rewards Loaded!");
  }

  // Returns a list of the current leaderboard
  Future<Either<String, List<User>>> fetchLeaderBoard() async {
    return await service.fetchLeaderBoard(_userController.authHeaders);
  }

  Future<Either<String, List<Reward>>> fetchCurrentUserRewards() async {
    final result = await service.fetchUserRewards(
        _userController.user.value!.id!, _userController.authHeaders);

    return result.fold((l) {
      return left(l);
    }, (r) async {
      for (Reward reward in r) {
        await RewardModelHelper().create(reward.toJson());
      }
      return right(r);
    });
  }

  Future<Either<String, List<Reward>>> loadRewards() async {
    final data = await RewardModelHelper().queryAll();

    if (data.isEmpty) {
      final result = await fetchCurrentUserRewards();
      return result.fold((l) => left(l), (r) async {
        r.map((e) async {
          await UserModelHelper().create(e.toJson());
        });
        return right(r);
      });
    }
    final rewards = data.map((e) => Reward.fromJson(e)).toList();
    return right(rewards);
  }
}
