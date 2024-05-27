import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

/// The ProfilePictureWidget displays a user's profile picture
/// accordingly representing the user's settings on whether to show
/// their picture or not
///
/// The [profileSize] parameter controls the size of the image
/// and the [hasStory] shows a badge on the widget incase

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    super.key,
    this.profileSize = 18,
    this.hasStory = false,
  });

  final double profileSize;
  final bool hasStory;

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    final userController = Get.find<UserController>();

    return Badge(
      alignment: Alignment.bottomLeft,
      smallSize: 8,
      backgroundColor: hasStory
          ? Theme.of(context).colorScheme.tertiary
          : Colors.transparent,
      child: CircleAvatar(
        radius: profileSize,
        child: Obx(
          () => ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(800),
            ),
            child:
                settingsController.settings.value!.showProfilePicture ?? false
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
                                    .replaceFirst("data:image/gif;base64,", ""),
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
    );
  }
}
