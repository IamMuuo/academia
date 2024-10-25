import 'package:flutter/material.dart';

import 'pages.dart';

class ScoreSection extends StatelessWidget {
  final int score;
  const ScoreSection({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    String quotes;
    String emoji;
    if (score >= 0 && score <= 3) {
      quotes = 'Keep Trying, You’re Almost There!';
      emoji = '😅';
    } else if (score >= 4 && score <= 6) {
      quotes = 'Well Done, You’re Making Progress!';
      emoji = '👏';
    } else if (score >= 7 && score <= 9) {
      quotes = 'Great Job, Keep Up the Good Work!';
      emoji = '👍';
    } else {
      quotes = 'Outstanding, You’ve Really Excelled!';
      emoji = '🏆';
    }
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'assets/images/congratulations_askMe.jpeg',
            fit: BoxFit.fill,
          ),
          const Spacer(),
          const Text(
            "Congratulations",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "You completed the test!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "your score".toUpperCase(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "$score/10",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            emoji,
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(height: 10),
          Text(
            quotes,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              //
            ),
          ),
          const Spacer(),
          FilledButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const AskMeHome()),
              );
            },
            child: const Text("Complete"),
          ),
        ],
      ),
    );
  }
}
