import 'package:academia/exports/barrel.dart';
import 'package:academia/notifier/notifier.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifierService().initialize();
  await LocalNotificationStatusManager().initialize();
  await BackgroundWorker().initialize();

  runApp(
    GetMaterialApp(
      home: const Academia(),
      theme: lightModeTheme,
      debugShowCheckedModeBanner: false,
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
    Get.put(NetworkController());
    Get.put(SettingsController());
    Get.put(TodoController());
    Get.put(RewardController());
    Get.put(CoursesController());
    Get.put(EventsController());

    LocalNotifierService().requestPermission();
    return Obx(
      () => userController.isLoggedIn.value
          ? const LayoutPage()
          : const IntroPage(),
    );
  }
}
