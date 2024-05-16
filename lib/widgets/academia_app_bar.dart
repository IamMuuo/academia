import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:story_view/controller/story_controller.dart';

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
    final notificationsController = Get.find<NotificationsController>();
    final UserController userController = Get.find<UserController>();
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            Obx(
              () => GestureDetector(
                onTap: notificationsController.hasNotifications.value
                    ? () {
                        Get.to(NotificationsStoryPage(
                          storyController: StoryController(),
                        ));
                      }
                    : null,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: notificationsController.hasNotifications.value
                      ? BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(50),
                          ),
                        )
                      : null,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: Obx(
                      () => ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(800),
                        ),
                        child: settingsController
                                    .settings.value!.showProfilePicture ??
                                false
                            ? userController.user.value == null
                                ? Image.asset(
                                    "assets/icons/academia.png",
                                    height: 400,
                                    width: 400,
                                    fit: BoxFit.fill,
                                  )
                                : Image.memory(
                                    Uint8List.fromList(
                                      base64Decode(
                                        userController.user.value!.profile!
                                            .replaceFirst(
                                                "data:image/gif;base64,", ""),
                                      ),
                                    ),
                                    fit: BoxFit.cover,
                                    width: 400,
                                    height: 400,
                                  )
                            : Image.asset(
                                userController.user.value!.gender == "male"
                                    ? "assets/images/male_student.png"
                                    : "assets/images/female_student.png",
                              ),
                      ),
                    ),
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
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const Spacer(),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: IconButton(
                onPressed: () {
                  ontapped == null
                      ? Get.to(const TimeLinePage())
                      : ontapped?.call();
                },
                icon: icon ?? const Icon(Ionicons.time_outline),
              ),
            )
          ],
        ),
      ),
    );
  }
}
