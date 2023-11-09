import 'package:academia/constants/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ToolCardController extends GetxController {
  var isLoading = false.obs;
}

class ToolCard extends StatelessWidget {
  const ToolCard({
    super.key,
    required this.ontap,
    required this.title,
    this.backGround,
    this.icon,
    this.titlestyle,
  });

  final Function ontap;
  final Color? backGround;
  final Icon? icon;
  final String title;
  final TextStyle? titlestyle;

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ToolCardController());
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backGround ?? Colors.blueAccent,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon ??
                    const Icon(
                      CupertinoIcons.hammer_fill,
                      color: Colors.white,
                    ),
                Obx(
                  () => controller.isLoading.value
                      ? LoadingAnimationWidget.hexagonDots(
                          size: 20, color: Colors.white)
                      : IconButton(
                          onPressed: () async {
                            controller.isLoading.value = true;
                            ontap();
                            controller.isLoading.value = false;
                          },
                          icon: const Icon(
                            CupertinoIcons.arrow_right_circle,
                            color: Colors.white,
                          ),
                        ),
                ),
              ],
            ),
            Text(
              title,
              style: titlestyle ??
                  h6.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
