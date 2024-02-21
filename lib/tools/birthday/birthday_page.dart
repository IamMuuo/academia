import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:academia/exports/barrel.dart';
import 'package:flutter/cupertino.dart';

class BirthDayPage extends StatelessWidget {
  const BirthDayPage({super.key});

  int get years {
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    var dob = inputFormat.parse(user.dateOfBirth!);
    return DateTime.now().year - dob.year;
  }

  @override
  Widget build(BuildContext context) {
    var settingsController = Get.find<SettingsController>();
    ScreenshotController screenshotController = ScreenshotController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            CupertinoIcons.xmark,
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              var img = await screenshotController.capture();
              if (img != null) {
                final directory = await getApplicationDocumentsDirectory();
                final imagePath =
                    await File('${directory.path}/image.png').create();
                await imagePath.writeAsBytes(img);
                Get.snackbar("Captured!",
                    "You can now find it on your gallery to share");
                debugPrint("Ok");
              }
            },
            icon: Icon(
              Icons.share,
              color: Theme.of(context).primaryColor,
            ),
          )
        ],
      ),
      body: Screenshot(
        controller: screenshotController,
        child: Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Happy",
                  style: h2.copyWith(color: Theme.of(context).primaryColorDark),
                ),
                Text(
                  "BirthDay",
                  textAlign: TextAlign.center,
                  style: h2.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Obx(
                    () => Stack(
                      children: [
                        CircleAvatar(
                          radius: 80.0,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(800),
                            ),
                            child: settingsController.showProfilePic.value
                                ? Image.memory(
                                    Uint8List.fromList(
                                      base64Decode(user.profile!.replaceFirst(
                                          "data:image/gif;base64,", "")),
                                    ),
                                  )
                                : Image.asset(user.gender == "male"
                                    ? "assets/images/male_student.png"
                                    : "assets/images/female_student.png"),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                            radius: 16,
                            child: Text(
                              "$years",
                              style: h6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 12, bottom: 3),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      user.name!.toString().title().split(" ")[0],
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  "assets/images/present2.png",
                  height: 300,
                  width: 300,
                ),
                const SizedBox(height: 12),
                const Text(
                  "To more years of prosperity, growth and learning🎂🎂",
                  textAlign: TextAlign.center,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/academia.png",
                      height: 60,
                    ),
                    const SizedBox(
                      width: 40,
                      child: Text(
                        "and",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Image.asset(
                      "assets/icons/dita.png",
                      height: 60,
                    )
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  "Celebrate you",
                  textAlign: TextAlign.center,
                  style: h5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
