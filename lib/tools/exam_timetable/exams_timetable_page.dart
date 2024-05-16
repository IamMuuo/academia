import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class ExamTimeTablePage extends StatefulWidget {
  const ExamTimeTablePage({super.key});

  @override
  State<ExamTimeTablePage> createState() => _ExamTimeTablePageState();
}

class _ExamTimeTablePageState extends State<ExamTimeTablePage> {
  final userController = Get.find<UserController>();
  final settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hello there!"),
      ),
    );
  }
}
