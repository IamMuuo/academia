import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<SettingsController>();
    final UserController userController = Get.find<UserController>();

    return Container(
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
                      child: controller.settings.value!.showProfilePicture ??
                              false
                          ? Image.memory(
                              Uint8List.fromList(
                                base64Decode(userController.user.value!.profile!
                                    .replaceFirst(
                                        "data:image/gif;base64,", "")),
                              ),
                              fit: BoxFit.contain,
                            )
                          : Image.asset(
                              userController.user.value!.gender == "male"
                                  ? "assets/images/male_student.png"
                                  : "assets/images/female_student.png",
                            ),
                    ),
                    Positioned(
                      right: 3,
                      bottom: 0,
                      child: Icon(
                        Ionicons.shield_checkmark,
                        color: Theme.of(context).colorScheme.tertiary,
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
              icon: Ionicons.id_card,
            ),
            InfoCard(
              title: "Admission Number",
              content: userController.user.value!.regno ?? "00-0000",
              icon: Ionicons.at_circle,
            ),
            InfoCard(
              title: "Gender",
              content: (userController.user.value!.gender ?? "unknown").title(),
              icon: (userController.user.value!.gender ?? "unknown")
                          .toLowerCase() ==
                      "male"
                  ? Icons.male
                  : Icons.female,
            ),
            InfoCard(
              title: "Email Address",
              content:
                  userController.user.value!.email ?? "someone@example.com",
              icon: Ionicons.mail,
            ),
            InfoCard(
              title: "Address",
              content: userController.user.value!.address ?? "unknown",
              icon: Ionicons.planet,
            ),
            InfoCard(
              title: "Birthday",
              content:
                  (userController.user.value!.dateOfBirth ?? "unknown").title(),
              icon: Icons.cake,
            ),
          ],
        ),
      ),
    );
  }
}
