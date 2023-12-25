import 'dart:convert';
import 'dart:typed_data';

import 'package:academia/constants/common.dart';
import 'package:academia/controllers/settings_controller.dart';
import 'package:academia/pages/time_line_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcademiaAppBar extends StatelessWidget {
  const AcademiaAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon,
    this.ontapped,
  });
  final String title;
  final String subtitle;
  final Icon? icon;
  final Function? ontapped;

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              child: Obx(
                () => ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(800),
                  ),
                  child: settingsController.showProfilePic.value
                      ? Image.memory(
                          Uint8List.fromList(
                            base64Decode(user.profile!
                                .replaceFirst("data:image/gif;base64,", "")),
                          ),
                          fit: BoxFit.cover,
                          width: 400,
                          height: 400,
                        )
                      : Image.asset(
                          user.gender == "male"
                              ? "assets/images/male_student.png"
                              : "assets/images/female_student.png",
                        ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: normal.copyWith(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                Text(
                  subtitle,
                  style: h6.copyWith(
                    color: Theme.of(context).primaryColorLight,
                  ),
                )
              ],
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorLight,
                borderRadius: const BorderRadius.all(Radius.circular(50)),
              ),
              child: IconButton(
                onPressed: () {
                  ontapped?.call() ?? Get.to(const TimeLinePage());
                },
                icon: icon ?? const Icon(Icons.timeline),
              ),
            )
          ],
        ),
      ),
    );
  }
}
