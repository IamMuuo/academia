// import 'package:flutter/material.dart';

// class ScoreSection extends StatelessWidget {
//   const ScoreSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Image.asset("assets/images/congratulations_askMe.jpeg"),
//           ),
//           Expanded(
//             flex: 3,
//             child: Stack(
//               alignment: Alignment.topCenter,
//               children: [
//                 Positioned.fill(
//                   child: Column(
//                     children: [
//                       Expanded(
//                         flex: 2,
//                         child: Container(
//                           color: Colors.white,
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: Container(
//                           color: const Color(0xFFB9D9EB),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(20),
//                   margin: const EdgeInsets.symmetric(horizontal: 16.0),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 5,
//                         blurRadius: 7,
//                         offset: const Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       const Text(
//                         "Congratulations",
//                         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         "You completed the test!",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
//                       ),
//                       const SizedBox(height: 20),
//                       Text(
//                         "your score".toUpperCase(),
//                         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 10),
//                       const Text(
//                         "3/10",
//                         style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 10),
//                       const Icon(
//                         Icons.sentiment_dissatisfied,
//                         color: Colors.yellow,
//                         size: 40,
//                       ),
//                       const SizedBox(height: 10),
//                       const Text(
//                         "You can do better",
//                         style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             height: 100,
//             color: const Color(0xFFB9D9EB),
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     // Implement later
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//                   ),
//                   child: const Text("Complete"),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class ScoreSection extends StatelessWidget {
  const ScoreSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset('assets/images/congratulations_askMe.jpeg',),
          ),
          Expanded(
            flex: 1,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: const Color(0xFF006399),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {}, 
                    child: const Text("Complete"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}