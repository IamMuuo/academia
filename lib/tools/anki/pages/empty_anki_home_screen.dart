import 'package:academia/exports/barrel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyAnkiHomeScreen extends StatelessWidget {
  const EmptyAnkiHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            "assets/lotties/study.json",
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Your anki space is a clean slate! 📝 Create your first topic and let Academia Anki help you ace those grades!",
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
