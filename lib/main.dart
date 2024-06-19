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
      // darkTheme: darkModeTheme,
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
    Get.put(NetworkController());
    Get.put(SettingsController());
    Get.put(TodoController());
    Get.put(RewardController());
    Get.put(CoursesController());

    // Prompt for permission
    AwesomeNotifications().isNotificationAllowed().then(
      (value) {
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
      },
    );

    return FutureBuilder(
      future: userController.loadUserFromDisk(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    "assets/icons/academia.png",
                    height: 200,
                  ),
                  const SizedBox(height: 22),
                  LoadingAnimationWidget.fourRotatingDots(
                    color: Theme.of(context).colorScheme.primary,
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Let the past die, kill it if you have to ~ The Last Jedi",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }
        return snapshot.hasData ? const HomePage() : const IntroPage();
      },
    );
  }
}
