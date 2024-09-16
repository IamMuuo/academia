// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../controllers/quizSettings_controller.dart';

// class TimerOptions extends StatelessWidget {
//   TimerOptions({super.key});

//   final QuizSettingsController settingsController = Get.put(QuizSettingsController());

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: List.generate(5, (index) {
//         int minute = index + 1;
//         return GestureDetector(
//           onTap: () {
//             settingsController.setSelectedTimer(minute);
//           },
//           child: Obx(
//             () => Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(15.0),
//               margin: const EdgeInsets.symmetric(vertical: 5.0),
//               decoration: BoxDecoration(
//                 color: settingsController.selectedTimer.value == minute
//                     ? Colors.pink[50]
//                     : Colors.transparent,
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: Center(
//                 child: Text(
//                   '$minute minute',
//                   style: TextStyle(
//                     fontSize: 16.0,
//                     color: settingsController.selectedTimer.value == minute
//                         ? Colors.black
//                         : Colors.grey,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }  