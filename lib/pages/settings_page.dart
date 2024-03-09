import 'package:academia/exports/barrel.dart';
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
          elevation: 0,
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
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Profile",
                icon: Icon(Icons.person_4),
              ),
              Tab(
                text: "Settings",
                icon: Icon(Icons.settings),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 70.0,
                      child: Obx(
                        () => Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(800),
                              ),
                              child: controller.showProfilePic.value
                                  ? Image.memory(
                                      Uint8List.fromList(
                                        base64Decode(userController
                                            .user.value!.profile!
                                            .replaceFirst(
                                                "data:image/gif;base64,", "")),
                                      ),
                                      fit: BoxFit.contain,
                                    )
                                  : Image.asset(
                                      userController.user.value!.gender ==
                                              "male"
                                          ? "assets/images/male_student.png"
                                          : "assets/images/female_student.png",
                                    ),
                            ),
                            Positioned(
                              right: 3,
                              bottom: 0,
                              child: Icon(
                                CupertinoIcons.checkmark_seal_fill,
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      userController.user.value!.name!.title(),
                      style: h4,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    InfoCard(
                      title: "National ID",
                      content: userController.user.value!.idno ?? "Unknown",
                      icon: Icons.numbers,
                    ),
                    InfoCard(
                      title: "Admission Number",
                      content: userController.user.value!.admno ?? "00-0000",
                      icon: Icons.person,
                    ),
                    InfoCard(
                      title: "Gender",
                      content: (userController.user.value!.gender ?? "unknown")
                          .title(),
                      icon: (userController.user.value!.gender ?? "unknown")
                                  .toLowerCase() ==
                              "male"
                          ? Icons.male
                          : Icons.female,
                    ),
                    InfoCard(
                      title: "Email Address",
                      content: userController.user.value!.email ??
                          "someone@example.com",
                      icon: Icons.email,
                    ),
                    InfoCard(
                      title: "Address",
                      content: userController.user.value!.address ?? "unknown",
                      icon: Icons.mail,
                    ),
                    InfoCard(
                      title: "Birthday",
                      content:
                          (userController.user.value!.dateOfBirth ?? "unknown")
                              .title(),
                      icon: Icons.cake_sharp,
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              () => ListView(
                children: [
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Academia Contributors",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
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
                                  CircleAvatar(
                                    radius: 33,
                                    backgroundColor:
                                        Theme.of(context).primaryColorDark,
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
                                  Text(
                                    snapshot.data![index]["login"],
                                    style: normal.copyWith(fontSize: 8),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : LoadingAnimationWidget.flickr(
                            leftDotColor: Theme.of(context).primaryColor,
                            rightDotColor: Theme.of(context).primaryColorDark,
                            size: 60),
                  ),
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
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Tool Settings",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
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
                  const Divider(),

                  const Divider(),

                  ListTile(
                    title: Obx(
                      () => controller.hasUpdates.value
                          ? const Text("Updating")
                          : Text("Update v2.0.${controller.patch.value}"),
                    ),
                    trailing: controller.hasUpdates.value
                        ? LoadingAnimationWidget.beat(
                            color: Theme.of(context).primaryColor, size: 20)
                        : IconButton(
                            onPressed: () async {
                              await controller.checkForUpdates();
                            },
                            icon:
                                const Icon(CupertinoIcons.arrow_right_circle)),
                  ),
                  const Divider(),

                  // button to refresh all content
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
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
                          userController
                              .logout()
                              .then((value) => Get.put(UserController()));
                          Get.offAll(const IntroPage());
                          Get.snackbar(
                            "Logout success",
                            "Please take your time to let us know what we would have done to make you stay",
                            backgroundColor: Colors.white,
                            icon: const Icon(CupertinoIcons.checkmark_seal),
                          );
                          NotificationService().showNotification(
                            id: notifications["user"] ?? 0,
                            body: "Goodbye friend see you maybe",
                            title: "Goodbye",
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
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
          ],
        ),
      ),
    );
  }
}
