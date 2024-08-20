import 'package:flutter/material.dart';

class ScoreSection extends StatelessWidget {
  final int score;
  const ScoreSection({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
  String quotes = '';
  if (score >= 0 && score <= 3) {
    quotes = 'Keep Trying, You’re Almost There!';
  } else if (score >= 4 && score <= 6) {
    quotes = 'Well Done, You’re Making Progress!';
  } else if (score >= 7 && score <= 9) {
    quotes = 'Great Job, Keep Up the Good Work!';
  } else {
    quotes = 'Outstanding, You’ve Really Excelled!';
  }
  
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("The End"),
      // ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Image.asset('assets/images/congratulations_askMe.jpeg', 
            width: 400,
            fit: BoxFit.cover,
            ),
          ),
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          //color: const Color(0xFFB9D9EB),
                          color: const Color(0xFF006399),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: const Color(0xFF006399),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  width: 500,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Congratulations",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "You completed the test!",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "your score".toUpperCase(),
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "$score/10",
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      const Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.yellow,
                        size: 40,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        quotes,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 100,
            color: const Color(0xFF006399),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Implement later
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  ),
                  child: const Text("Complete"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


