import 'package:get/get.dart';
import 'package:academia/exports/barrel.dart';

final List<Map<String, dynamic>> allTools = [
  {
    "id": 8,
    "name": "Exam Timetable",
    "action": "Show exam timetable",
    "image": "assets/images/sketchbook-man-analyzing-business-data.png",
    "ontap": () {
      Get.to(const ExamTimeTablePage());
    },
    "description":
        "Exams around the corner? Don't panic we've got you covered with the timetable",
  },
  {
    "id": 1,
    "name": "GPA Calculator",
    "action": "Calculate GPA",
    "image":
        "assets/images/sketchbook-young-businesswoman-giving-a-presentation-1.png",
    "ontap": () {
      Get.to(GpaCalculator());
    },
    "description": "Wanna calculate your GPA? try it here"
  },
  {
    "id": 2,
    "name": "Fees statements",
    "action": "Preview my fees statements",
    "image": "assets/images/sketchbook-woman-and-a-man-analyze-data-2.png",
    "ontap": () {
      Get.to(const FeesPage());
    },
    "description": "Having trouble tracking your finaces? We're here for you"
  },

  {
    "id": 2,
    "name": "Elearning",
    "image": "assets/images/sketchbook-coworkers-discussing-something-1.png",
    "action": "Visit Elearning",
    "ontap": () {
      Platform.isIOS || Platform.isAndroid
          ? Get.to(const WebviewPage(
              title: "Elearning", url: "https://elearning.daystar.ac.ke"))
          : Get.rawSnackbar(
              title: "Missing Feature",
              message:
                  "Current platform does not support this feature please try it on android",
              backgroundColor: Colors.red,
              snackPosition: SnackPosition.BOTTOM,
            );
    },
    "description":
        "Psst! Elearning is here for you. Keep track of your assignments and notes!",
  },
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
    "id": 9,
    "name": "Task Manager",
    "action": "Manage your tasks",
    "image": "assets/images/organize.png",
    "ontap": () {
      Get.to(const TodoHomeScreen());
    },
    "description":
        "Having trouble keeping track of your todos? We've got you covered",
  },
  {
    "id": 10,
    "name": "Anki Flash Cards",
    "action": "Lets Up That Grade",
    "image":
        "assets/images/sketchbook-young-man-and-his-dog-are-having-a-picnic-in-the-park-1.png",
    "ontap": () {
      Get.to(const AnkiHomePage());
    },
    "description":
        "Ready to revolutionize your study habits?\nLet's help you master courses effortlessly",
  },
  {
    "id": 11,
    "name": "Ask Me",
    "action": "Study with Ai",
    "image":
        "assets/images/sketchbook-woman-taking-pictures-of-packaged-goods.png",
    "ontap": () {
      Get.to(const AskMeHome());
    },
    "description":
        "Generate quiz questions from your notes and study materials with our AI tool."
  }
];
