import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class ExamTimeTablePage extends StatelessWidget {
  const ExamTimeTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Image.asset("assets/images/girl_sitted.png"),
          ),
          const Text("Exam timetable coming soon😉"),
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text("Notify me when its ready"),
          ),
        ],
      ),
    );
  }
}
