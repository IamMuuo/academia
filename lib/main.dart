import 'package:academia/exports/barrel.dart';
import 'package:academia/services/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().initNotifications();
  // Init flutter
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(ScheduleAdapter());
  Hive.registerAdapter(CoursesAdapter());
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(ExamAdapter());
  appDB = await Hive.openBox(dbName);

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

  /// The user controller is injected seperately since its used in this file
  /// and a reference to it is needed to check for login
  final userController =
      ControllerService().injectController(UserController()) as UserController;

  runApp(
    GetMaterialApp(
      home: userController.isLoggedIn.value
          ? const HomePage()
          : const IntroPage(),
      theme: lightModeTheme,
      darkTheme: darkModeTheme,
    ),
  );
}
