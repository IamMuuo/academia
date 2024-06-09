import 'package:academia/exports/barrel.dart';
import 'package:flutter/material.dart';

class PersonalRatingWidget extends StatelessWidget {
  const PersonalRatingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/coin.png",
            height: 80,
          ),
          const SizedBox(height: 8),
          Text(
            "1000 vibe points",
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const Text("earned"),
          const Spacer(),
          Text(
            "Keep the streak burning; earn more points enjoy exclusive features and rewards",
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
