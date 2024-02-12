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

  bool isLoggedIn = false;
  if (appDB.containsKey("user")) {
    user = await appDB.get("user");
    isLoggedIn = true;
    magnet = Magnet(user.admno!, user.password!);
  }

  // Init settings controller
  Get.put(SettingsController());
  Get.put(NotificationsController());

  // Init TasksManager controller
  Get.put(TaskManagerController());

  runApp(
    GetMaterialApp(
      home: isLoggedIn ? const HomePage() : const IntroPage(),
      theme: lightModeTheme,
    ),
  );
}
