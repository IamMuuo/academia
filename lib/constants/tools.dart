import 'package:get/get.dart';
import 'package:academia/exports/barrel.dart';

final List<Map<String, dynamic>> allTools = [
  // {
  //   "id": 8,
  //   "name": "Exam Timetable",
  //   "action": "Show exam timetable",
  //   "image": "assets/images/exam_timetable.png",
  //   "ontap": () {
  //     // Get.to(const ExamTimeTablePage());
  //   },
  //   "description":
  //       "Exams around the corner? Don't panic we've got you covered with the timetable",
  // },
  {
    "id": 1,
    "name": "GPA Calculator",
    "action": "Calculate GPA",
    "image": "assets/images/calculator.png",
    "ontap": () {},
    "description": "Wanna calculate your GPA? try it here"
  },
  {
    "id": 2,
    "name": "Fees statements",
    "action": "Preview my fees statements",
    "image": "assets/images/coin.png",
    "ontap": () {
      Get.to(const FeesPage());
    },
    "description": "Having trouble tracking your finaces? We're here for you"
  },

  // {
  //   "id": 2,
  //   "name": "Elearning",
  //   "image": "assets/images/grade.png",
  //   "action": "Visit Elearning",
  //   "ontap": () {
  //     Platform.isIOS || Platform.isAndroid
  //         ? Get.to(const WebviewPage(
  //             title: "Elearning", url: "https://elearning.daystar.ac.ke"))
  //         : showCustomSnackbar(
  //             "Missing Feature",
  //             "Please use a mobile phone to access this service since it isn't supported on desktop",
  //             icon: Icons.error,
  //           );
  //   },
  //   "description":
  //       "Psst! Elearning is here for you. Keep track of your assignments and notes!",
  // },
  // {
  //   "id": 3,
  //   "name": "Fees Statement",
  //   "action": "Get my fee statement",
  //   "image": "assets/images/fees.png",
  //   "ontap": () async {
  //     // var controller = Get.find<SettingsController>();
  //     // if (!(controller.settings.value!.showFeeStatistics ?? false)) {
  //     //   showCustomSnackbar(
  //     //     "Tool locked",
  //     //     "Fees functionality is locked in the settings page, please unlock it to view your fees statement",
  //     //     icon: Icons.lock,
  //     //   );
  //     // } else {
  //     try {
  //       var statements = await magnet.fetchFeeStatement();
  //       Get.to(FeesPage(allStatements: statements));
  //     } catch (e) {
  //       //   showCustomSnackbar(
  //       //     "Error",
  //       //     "Please check your internet connection and try again!",
  //       //     icon: Icons.network_check,
  //       //   );
  //     }
  //   },
  //   // },
  //   "description": "Not sure about finances? We are here for you"
  // },
  // {
  //   "id": 4,
  //   "name": "Generate Catering Token",
  //   "action": "Generate Token",
  //   "image": "assets/images/food.png",
  //   "ontap": () async {
  //     try {
  //       var token = await magnet.fetchCateringToken();
  //       await Get.defaultDialog(
  //         title: "Your Token",
  //         content: Text("Your Token is ${token['message'] ?? ''}"),
  //       );
  //     } catch (e) {
  //       // showCustomSnackbar(
  //       //   "Error",
  //       //   "Please check your internet connection and try again!",
  //       //   icon: Icons.network_check,
  //       // );
  //     }
  //   },
  // "description": "Hungry? Maybe its time to generate your catering token!"
  // },
  // {
  //   "id": 5,
  //   "name": "Student Audit",
  //   "action": "Get my audit",
  //   "image": "assets/images/view.png",
  //   "ontap": () async {
  //     var controller = Get.find<SettingsController>();
  //     if ((controller.settings.value!.enableAudit ?? false)) {
  //       showCustomSnackbar(
  //         "Tool locked",
  //         "Student Audit functionality is locked in the settings page, please unlock it to view your student audit",
  //         icon: Icons.lock,
  //       );
  //     } else {
  //       final UserController userController = Get.find<UserController>();
  //       Get.to(PdfViewer(
  //         title: "Your audit",
  //         url:
  //             "https://student.daystar.ac.ke/Downloads/STDAUDIT-${userController.user.value!.regno}.pdf",
  //       ));
  //     }
  //   },
  //   "description": "Having trouble finding your audit? Here it is"
  // },
  // {
  //   "id": 6,
  //   "name": "Transcript",
  //   "action": "Get my transcript",
  //   "image": "assets/images/graduating.png",
  //   "ontap": () async {
  //     var controller = Get.find<SettingsController>();
  //     if (controller.settings.value!.enableTranscript ?? false) {
  //       showCustomSnackbar(
  //         "Tool locked",
  //         "Transcript functionality is locked in the settings page, please unlock it to view your transcript",
  //         icon: Icons.lock,
  //       );
  //     } else {
  //       final UserController userController = Get.find<UserController>();
  //       Get.to(PdfViewer(
  //         title: "Your Transcript",
  //         url:
  //             "https://student.daystar.ac.ke/Downloads/PROVISIONAL%20RESULTS-${userController.user.value!.regno}.pdf",
  //       ));
  //     }
  //   },
  //   "description": "Need your transcript ASAP? Find it here"
  // },
  {
    "id": 7,
    "name": "Class Attendance",
    "action": "View class Attendance",
    "image": "assets/images/girl_sitted.png",
    "ontap": () {},
    "description":
        "Curious to know how many classes you have missed this semester, this might be the tool",
  },
  {
    "id": 9,
    "name": "Task Manager",
    "action": "Manage your tasks",
    "image": "assets/images/tasks_manager.png",
    "ontap": () {
      Get.to(const TodoHomeScreen());
    },
    "description":
        "Having trouble keeping track of your Assignments? We've got you covered",
  },
  {
    "id": 10,
    "name": "Ask Me",
    "action": "Ask Me",
    "image": "assets/images/think.jpeg",
    "ontap": () {
      Get.to(AskMeDashboard());
    },
    "description": "Generate quiz questions from your notes and study materials with our AI tool."

  }
];
