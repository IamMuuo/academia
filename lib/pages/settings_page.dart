import 'package:academia/controllers/settings_controller.dart';
import 'package:academia/pages/webview_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/common.dart';
import 'intro_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<SettingsController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(CupertinoIcons.xmark),
        ),
        title: const Text("Settings"),
        actions: [
          IconButton(
            tooltip: "About this app",
            onPressed: () {
              Get.to(
                const WebviewPage(
                  title: "About Academia",
                  url:
                      "https://github.com/IamMuuo/academia/blob/main/README.md",
                ),
              );
            },
            icon: const Icon(CupertinoIcons.question_circle),
          ),
          IconButton(
            tooltip: "Logout",
            onPressed: () {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(
        () => ListView(
          children: [
            // Personal
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Personal Settings",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            ListTile(
              title: const Text("Show my profile picture"),
              trailing: Switch(
                  value: controller.showProfilePic.value,
                  onChanged: (value) async {
                    controller.showProfilePic.value = value;
                    await controller.saveSettings();
                  }),
            ),

            ListTile(
              title: const Text("Show GPA"),
              trailing: Switch(
                  value: controller.showGPA.value,
                  onChanged: (value) async {
                    controller.showGPA.value = value;
                    await controller.saveSettings();
                  }),
            ),

            const Divider(),

            // Todos
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Todo Settings",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            ListTile(
              title: const Text("Show todos on carousel"),
              trailing: Switch(value: true, onChanged: (value) {}),
            ),
            const Divider(),
            ListTile(
              title: const Text("Delete older todo items"),
              trailing: Switch(value: true, onChanged: (value) {}),
            ),

            // notifications

            const Divider(),
            const Align(
              alignment: Alignment.center,
              child: Text(
                "Notifications",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: const Text("Allow push notifications"),
              trailing: Switch(value: true, onChanged: (value) {}),
            ),
            const Divider(),
            ListTile(
              title: const Text("Only show really important notifications"),
              trailing: Switch(value: true, onChanged: (value) {}),
            ),
            const Divider(),

            const Align(
              alignment: Alignment.center,
              child: Text(
                "Features",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            ListTile(
              title: const Text("Report a bug or issue"),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.arrow_right_circle),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text("How to contribute to Academia"),
              trailing: IconButton(
                  onPressed: () {
                    Get.to(
                      const WebviewPage(
                          title: "How to contribute",
                          url:
                              "https://github.com/IamMuuo/academia/blob/main/CONTRIBUTING.md"),
                    );
                  },
                  icon: const Icon(CupertinoIcons.arrow_right_circle)),
            ),

            const Divider(),
            ListTile(
              title: const Text("How to contact us"),
              trailing: IconButton(
                  onPressed: () {
                    Get.to(const WebviewPage(
                        title: "DITA Contact",
                        url: "https://dita.co.ke/#contact"));
                  },
                  icon: const Icon(CupertinoIcons.arrow_right_circle)),
            ),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: TextField(
                // controller: dashBoardController.searchBoxController,
                maxLines: 4,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  filled: true,
                  // fillColor: Colors.blue[400],
                  hintText: 'Please describe your feature',
                  hintStyle: TextStyle(
                    color: Colors.black,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
              ),
            ),

            // button to refresh all content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: ElevatedButton(
                // log out the use
                onPressed: () async {
                  bool flag = await Get.defaultDialog(
                    title: "Confirmation",
                    content: Column(
                      children: [
                        Image.asset(
                          "assets/images/bot_sad.png",
                          height: 80,
                          width: 80,
                        ),
                        const Text("Are you sure you wish to leave?"),
                      ],
                    ),
                    textConfirm: "Leave",
                    textCancel: "I'll stay",
                    onCancel: () {
                      Get.back(result: false);
                    },
                    onConfirm: () => Get.back(result: true),
                  );

                  if (flag) {
                    user.logout();
                    Get.offAll(const IntroPage());
                    Get.snackbar(
                      "Logout success",
                      "Please take your time to let us know what we would have done to make you stay",
                      backgroundColor: Colors.white,
                      icon: const Icon(CupertinoIcons.checkmark_seal),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 0,
                  minimumSize: const Size(300, 60),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                ),
                child: const Text(
                  'Log out',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            Image.asset(
              "assets/icons/branding.png",
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
