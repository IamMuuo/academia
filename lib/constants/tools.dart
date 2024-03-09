import 'package:get/get.dart';
import 'package:academia/exports/barrel.dart';

final List<Map<String, dynamic>> allTools = [
  {
    "id": 1,
    "name": "GPA Calculator",
    "action": "Calculate GPA",
    "image": "assets/images/calculator.png",
    "ontap": () {
      Get.to(GpaCalculator());
    },
    "description": "Wanna calculate your GPA? try it here"
  },
  {
    "id": 2,
    "name": "Elearning",
    "image": "assets/images/grade.png",
    "action": "Visit Elearning",
    "ontap": () {
      Get.to(const WebviewPage(
          title: "Elearning", url: "https://elearning.daystar.ac.ke"));
    },
    "description":
        "Psst! Elearning is here for you. Keep track of your assignments and notes!",
  },
  {
    "id": 3,
    "name": "Fees Statement",
    "action": "Get my fee statement",
    "image": "assets/images/fees.png",
    "ontap": () async {
      var controller = Get.find<SettingsController>();
      if (!controller.showFees.value) {
        showCustomSnackbar("Tool locked",
            "Fees functionality is locked in the settings page, please unlock it to view your fees statement",
            icon: Icons.lock);
      } else {
        try {
          var statements = await magnet.fetchFeeStatement();
          Get.to(FeesPage(allStatements: statements));
        } catch (e) {
          showCustomSnackbar(
            "Error",
            "Please check your internet connection and try again!",
            icon: Icons.network_check,
          );
        }
      }
    },
    "description": "Not sure about finances? We are here for you"
  },
  {
    "id": 4,
    "name": "Generate Catering Token",
    "action": "Generate Token",
    "image": "assets/images/food.png",
    "ontap": () async {
      try {
        var token = await magnet.fetchCateringToken();
        await Get.defaultDialog(
          title: "Your Token",
          content: Text("Your Token is ${token['message'] ?? ''}"),
        );
      } catch (e) {
        showCustomSnackbar(
          "Error",
          "Please check your internet connection and try again!",
          icon: Icons.network_check,
        );
      }
    },
    "description": "Hungry? Maybe its time to generate your catering token!"
  },
  {
    "id": 5,
    "name": "Student Audit",
    "action": "Get my audit",
    "image": "assets/images/view.png",
    "ontap": () async {
      var controller = Get.find<SettingsController>();
      if (controller.showAudit.value) {
        showCustomSnackbar(
          "Tool locked",
          "Student Audit functionality is locked in the settings page, please unlock it to view your student audit",
          icon: Icons.lock,
        );
      } else {
        final UserController userController = Get.find<UserController>();
        Get.to(PdfViewer(
          title: "Your audit",
          url:
              "https://student.daystar.ac.ke/Downloads/STDAUDIT-${userController.user.value!.admno}.pdf",
        ));
      }
    },
    "description": "Having trouble finding your audit? Here it is"
  },
  {
    "id": 6,
    "name": "Transcript",
    "action": "Get my transcript",
    "image": "assets/images/graduating.png",
    "ontap": () async {
      var controller = Get.find<SettingsController>();
      if (controller.showTranscript.value) {
        showCustomSnackbar(
          "Tool locked",
          "Transcript functionality is locked in the settings page, please unlock it to view your transcript",
          icon: Icons.lock,
        );
      } else {
        final UserController userController = Get.find<UserController>();
        Get.to(PdfViewer(
          title: "Your Transcript",
          url:
              "https://student.daystar.ac.ke/Downloads/PROVISIONAL%20RESULTS-${userController.user.value!.admno}.pdf",
        ));
      }
    },
    "description": "Need your transcript ASAP? Find it here"
  },
  {
    "id": 7,
    "name": "Class Attendance",
    "action": "View class Attendance",
    "image": "assets/images/girl_sitted.png",
    "ontap": () {
      Get.to(const AttendancePage());
    },
    "description":
        "Curious to know how many classes you have missed this semester, this might be the tool",
  },
  {
    "id": 8,
    "name": "Exam Timetable",
    "action": "Show exam timetable",
    "image": "assets/images/exam_timetable.png",
    "ontap": () {
      Get.to(const ExamTimeTablePage());
    },
    "description":
        "Exams around the corner? Don't panic we've got you covered with the timetable",
  },
  {
    "id": 9,
    "name": "Task Manager",
    "action": "Manage your tasks",
    "image": "assets/images/tasks_manager.png",
    "ontap": () {
      Get.to(TaskManagerPage());
    },
    "description":
        "Having trouble keeping track of your Assignments? We've got you covered",
  }
];
