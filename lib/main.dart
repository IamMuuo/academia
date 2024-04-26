import 'package:academia/exports/barrel.dart';
import 'package:academia/services/services.dart';
import 'package:get/get.dart';

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

  // Init the storage service
  await StorageService().init();
  StorageService().registerAdapters<User>(UserAdapter());
  StorageService().registerAdapters<Schedule>(ScheduleAdapter());
  StorageService().registerAdapters<Courses>(CoursesAdapter());
  StorageService().registerAdapters<Task>(TaskAdapter());
  StorageService().registerAdapters<Exam>(ExamAdapter());

  // Initialize the various controllers
  // once you append the controller onto the list don't inject it again
  // since it will be placed in the context
  ControllerService().injectMultipleControllers(
    <GetxController>[
      SettingsController(),
      NotificationsController(),
      TaskManagerController(),
    ],
  );

  ControllerService().injectController(UserController());
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
    final UserController userController = Get.find<UserController>();
    return userController.isLoggedIn.value
        ? const HomePage()
        : const IntroPage();
  }
}
