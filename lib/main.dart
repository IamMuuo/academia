import 'package:academia/exports/barrel.dart';
import 'package:academia/notifier/notifier.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotifierService().initialize();
  await LocalNotificationStatusManager().initialize();
  await BackgroundWorker().initialize();

  runApp(
    const Academia(),
  );
}

class Academia extends StatelessWidget {
  const Academia({
    super.key,
  });

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
    Get.put(OrganizationController());

    LocalNotifierService().requestPermission();
    return GetMaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.amber,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: Colors.amber,
      ),
      home: Obx(
        () => userController.isLoggedIn.value
            ? const LayoutPage()
            : const IntroPage(),
      ),
    );
  }
}
