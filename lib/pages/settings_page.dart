import 'package:academia/exports/barrel.dart';
import 'package:academia/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<SettingsController>();
    final UserController userController = Get.find<UserController>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("More"),
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
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "My Profile",
                icon: Icon(Ionicons.person_circle_outline),
              ),
              Tab(
                text: "Settings",
                icon: Icon(Ionicons.settings_outline),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const ProfilePage(),
            Obx(
              () => ListView(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Academia Contributors",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),

                  // Devs
                  FutureBuilder(
                    future: magnet.fetchContributors(),
                    builder: (context, snapshot) => snapshot.hasData
                        ? SizedBox(
                            height: 120,
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Platform.isAndroid || Platform.isIOS
                                          ? Get.to(
                                              WebviewPage(
                                                url: snapshot.data![index]
                                                    ["html_url"],
                                                title: "Academia Contributor",
                                              ),
                                            )
                                          : showCustomSnackbar(
                                              "Missing Feature",
                                              "Webviews are not implemented on Desktop platforms!",
                                              icon: Icons.error,
                                            );
                                    },
                                    child: CircleAvatar(
                                      radius: 33,
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50)),
                                        child: CachedNetworkImage(
                                          height: 65,
                                          fit: BoxFit.contain,
                                          imageUrl: snapshot.data![index]
                                              ["avatar_url"],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    snapshot.data![index]["login"],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          fontSize: 8,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : LoadingAnimationWidget.flickr(
                            leftDotColor:
                                Theme.of(context).colorScheme.tertiary,
                            rightDotColor:
                                Theme.of(context).colorScheme.primary,
                            size: 60),
                  ),
                  // Personal
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Personal Settings",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),

                  ListTile(
                    title: const Text("Show my profile picture"),
                    trailing: Switch(
                      value: controller.showProfilePic.value,
                      onChanged: (value) async {
                        controller.showProfilePic.value = value;
                        await controller.saveSettings();
                      },
                    ),
                  ),
                  const Divider(),

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
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Tool Settings",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),

                  ListTile(
                    title: const Text("Lock showing audit tool"),
                    trailing: Switch(
                        value: controller.showAudit.value,
                        onChanged: (value) async {
                          controller.showAudit.value = value;
                          await controller.saveSettings();
                        }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text("Lock showing transcript tool"),
                    trailing: Switch(
                        value: controller.showTranscript.value,
                        onChanged: (value) async {
                          controller.showTranscript.value = value;
                          await controller.saveSettings();
                        }),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text("Show fees statistics"),
                    trailing: Switch(
                        value: controller.showFees.value,
                        onChanged: (value) async {
                          controller.showFees.value = value;
                          await controller.saveSettings();
                        }),
                  ),

                  // notifications

                  const Divider(),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Notifications",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  ListTile(
                    title: const Text("Show exam timetable during exam period"),
                    trailing: Switch(
                        value: controller.showExamTimeTable.value,
                        onChanged: (value) async {
                          controller.showExamTimeTable.value = value;
                          await controller.saveSettings();
                        }),
                  ),
                  const Divider(),

                  ListTile(
                    title: const Text("Wish me happy birthday"),
                    trailing: Switch(
                        value: controller.birthdayNotify.value,
                        onChanged: (value) async {
                          controller.birthdayNotify.value = value;
                          await controller.saveSettings();
                        }),
                  ),
                  const Divider(),

                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Features",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      showCustomSnackbar(
                        "Missing Feature",
                        "Feedback feature is yet to be implemented but you could still leave a feedback on the store",
                        icon: Icons.error,
                      );
                    },
                    title: const Text("Report a bug or issue"),
                    trailing: IconButton(
                      onPressed: () {
                        showCustomSnackbar(
                          "Missing Feature",
                          "Feedback feature is yet to be implemented but you could still leave a feedback on the store",
                          icon: Icons.error,
                        );
                      },
                      icon: const Icon(Ionicons.arrow_forward_circle_outline),
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      Get.to(
                        const WebviewPage(
                            title: "How to contribute",
                            url:
                                "https://github.com/IamMuuo/academia/blob/main/CONTRIBUTING.md"),
                      );
                    },
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
                        icon:
                            const Icon(Ionicons.arrow_forward_circle_outline)),
                  ),

                  const Divider(),
                  ListTile(
                    onTap: () {
                      Get.to(const WebviewPage(
                          title: "DITA Contact",
                          url: "https://dita.co.ke/#contact"));
                    },
                    title: const Text("How to contact us"),
                    trailing: IconButton(
                        onPressed: () {
                          Get.to(const WebviewPage(
                              title: "DITA Contact",
                              url: "https://dita.co.ke/#contact"));
                        },
                        icon:
                            const Icon(Ionicons.arrow_forward_circle_outline)),
                  ),
                  const Divider(),

                  ListTile(
                    onTap: () async {
                      await controller.checkForUpdates();
                    },
                    title: Obx(
                      () => controller.hasUpdates.value
                          ? const Text("Updating")
                          : Text(
                              "Update v2.${controller.patch.value}",
                            ),
                    ),
                    trailing: controller.hasUpdates.value
                        ? LoadingAnimationWidget.beat(
                            color: Theme.of(context).colorScheme.tertiary,
                            size: 20,
                          )
                        : IconButton(
                            onPressed: () async {
                              await controller.checkForUpdates();
                            },
                            icon: const Icon(
                                Ionicons.arrow_forward_circle_outline)),
                  ),
                  const Divider(),

                  // button to refresh all content
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: FilledButton(
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
                          await userController.logout();
                          Get.put(UserController());

                          // Navigate to intro page
                          Get.offAll(const IntroPage());
                          Get.snackbar(
                            "Logout success",
                            "Please take your time to let us know what we would have done to make you stay",
                            icon: const Icon(CupertinoIcons.checkmark_seal),
                          );
                        }
                      },

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
          ],
        ),
      ),
    );
  }
}
