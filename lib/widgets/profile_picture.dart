import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

/// The ProfilePictureWidget displays a user's profile picture
/// accordingly representing the user's settings on whether to show
/// their picture or not
///
/// The [profileSize] parameter controls the size of the image

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    super.key,
    this.profileSize = 18,
  });

  final double profileSize;

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    final userController = Get.find<UserController>();

    return CircleAvatar(
      radius: profileSize,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(800),
        ),
        child: Obx(
          () => settingsController.settings.value.showProfilePicture
              ? userController.user.value == null
                  ? Image.asset(
                      "assets/icons/academia.png",
                      height: 400,
                      width: 400,
                      fit: BoxFit.fill,
                    )
                  : userController.user.value!.profileUrl.startsWith("http")
                      ? CachedNetworkImage(
                          placeholder: (context, progress) =>
                              const CircularProgressIndicator(),
                          imageUrl: userController.user.value!.profileUrl,
                          errorWidget: (context, error, url) => Image.asset(
                            userController.user.value!.gender == "male"
                                ? "assets/images/male_student.png"
                                : "assets/images/female_student.png",
                          ),
                          fit: BoxFit.cover,
                          height: 300,
                        )
                      : Image.memory(
                          Uint8List.fromList(
                            base64Decode(
                              userController.user.value!.profileUrl
                                  .replaceFirst("data:image/gif;base64,", ""),
                            ),
                          ),
                          fit: BoxFit.cover,
                        )
              : Image.asset(
                  userController.user.value!.gender == "male"
                      ? "assets/images/male_student.png"
                      : "assets/images/female_student.png",
                ),
        ),
      ),
    );
  }
}
