import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:academia/storage/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize the flutter notifications plugin
  AwesomeNotifications().initialize(
    'resource://drawable/app_icon',
    [
      NotificationChannel(
        channelKey: "basic_channel",
        channelName: "Basic Notifications",
        channelDescription: "All Academia Notification Channel",
        importance: NotificationImportance.High,
        enableLights: true,
        defaultColor: Colors.blueGrey,
        playSound: true,
        enableVibration: true,
        channelShowBadge: true,
      )
    ],
  );

  await DatabaseHelper().initDatabase();

  runApp(
    GetMaterialApp(
      home: const Academia(),
      theme: lightModeTheme,
      darkTheme: darkModeTheme,
    ),
  );
}

class Academia extends StatelessWidget {
  const Academia({super.key});

  @override
  Widget build(BuildContext context) {
    /// Init the controllers here
    final userController = Get.put(UserController());
    Get.put(NotificationsController());
    Get.put(SettingsController());
    Get.put(TodoController());

    // Prompt for permission
    AwesomeNotifications().isNotificationAllowed().then((value) {
      if ((!value) && (Platform.isAndroid || Platform.isIOS)) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Allow Notifications"),
                content: const Text(
                  "Academia would like to send you notifications about classes and your school work",
                ),
                actions: [
                  FilledButton(
                    onPressed: () {
                      AwesomeNotifications()
                          .requestPermissionToSendNotifications()
                          .then((value) => Navigator.pop(context));
                    },
                    child: const Text("Allow"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("No"),
                  ),
                ],
              );
            });
      }
    });

    return Obx(
      () => userController.isLoggedIn.value
          ? const HomePage()
          : const IntroPage(),
    );
  }
}
