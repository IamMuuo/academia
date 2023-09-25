import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:academia/constants/common.dart';

class ProfilePageController extends GetxController {
  Widget buildProfilePicture() {
    return CircleAvatar(
      radius: 60.0,
      child: CachedNetworkImage(
          imageUrl: user.profile!,
          placeholder: (context, url) => LoadingAnimationWidget.beat(
                color: Theme.of(context).primaryColor,
                size: 80,
              ),
          errorWidget: (context, url, error) {
            Get.snackbar(
              "Error",
              error.toString(),
              icon: const Icon(
                CupertinoIcons.xmark_circle,
                color: Colors.red,
              ),
              maxWidth: 500,
            );
            return user.gender! == "male"
                ? Image.asset(
                    "assets/images/male_student.png",
                  )
                : Image.asset(
                    "assets/images/female_student.png",
                  );
          }),
    );
  }
}
