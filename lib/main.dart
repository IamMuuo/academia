import 'package:academia/exports/barrel.dart';
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
  appDB = await Hive.openBox(dbName);

  // Init settings controller
  final userController = Get.put(UserController());
  Get.put(SettingsController());
  Get.put(NotificationsController());

  // Init TasksManager controller
  Get.put(TaskManagerController());

  runApp(
    GetMaterialApp(
      home: userController.isLoggedIn.value
          ? const HomePage()
          : const IntroPage(),
      theme: lightModeTheme,
    ),
  );
}
