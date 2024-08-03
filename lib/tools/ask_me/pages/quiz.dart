// import 'package:academia/tools/tools.dart';
// import 'package:flutter/material.dart';

// class Quiz extends StatelessWidget {
//   const Quiz({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.of(context).pop();
//           },   
//         ),

//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Padding(
//               padding: const EdgeInsets.all(2.0),
//               child: Image.asset(
//                 'assets/images/think.jpeg',
//                 fit: BoxFit.contain,
//                 ),
//               ),
//               ),
//           Expanded(
//             flex: 1,
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(2.0),
//               decoration: const BoxDecoration(
//                 color: Color(0xFF934171),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(20.0),
//                   topRight: Radius.circular(20.0),
//                 ),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Welcome!',
//                     style: TextStyle(
//                       fontSize: 24.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 10.0,),
//                   const Text(
//                     'Are you ready\nfor your quiz?',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 28.0,
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 10,),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context, 
//                         MaterialPageRoute(builder: (context) => QuizSettings())
//                         );
//                     }, 
//                     style: ElevatedButton.styleFrom(
//                       shape: const CircleBorder(),
//                       padding: const EdgeInsets.all(20),
//                       //foregroundColor: Colors.white,
//                       backgroundColor: Colors.white,
//                     ),
//                     child: const Icon(
//                       Icons.arrow_forward,
//                       color: Colors.pinkAccent,
//                       size: 30.0,
//                     ),
//                     ),
//                 ],
//               ),
//             ),
//             ),    
//         ],
//       ),
//     );
//   }
// }