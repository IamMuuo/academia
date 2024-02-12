import 'package:academia/exports/barrel.dart';
import 'package:academia/pages/notifications_story_page.dart';
import 'package:academia/pages/time_line_page.dart';
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
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorDark,
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Row(
          children: [
            Obx(
              () => GestureDetector(
                onTap: notificationsController.hasNotifications.value
                    ? () {
                        debugPrint("Has notifications");
                        Get.to(NotificationsStoryPage(
                          storyController: StoryController(),
                        ));
                      }
                    : () {},
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: notificationsController.hasNotifications.value
                      ? const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(50)))
                      : null,
                  child: CircleAvatar(
                    radius: 20.0,
                    child: Obx(
                      () => ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(800),
                        ),
                        child: settingsController.showProfilePic.value
                            ? Image.memory(
                                Uint8List.fromList(
                                  base64Decode(user.profile!.replaceFirst(
                                      "data:image/gif;base64,", "")),
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
                  style: normal.copyWith(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                Text(
                  subtitle,
                  style: normal.copyWith(
                    color: Theme.of(context).primaryColorLight,
                    fontWeight: FontWeight.bold,
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
                  ontapped == null
                      ? Get.to(const TimeLinePage())
                      : ontapped?.call();
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
