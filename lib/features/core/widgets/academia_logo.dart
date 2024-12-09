import 'package:flutter/material.dart';

class AcademiaLogo extends StatelessWidget {
  const AcademiaLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            child: Image.asset("assets/icons/academia.png"),
          ),
          const SizedBox(width: 2),
          Text(
            "Academia",
            style: Theme.of(context).textTheme.headlineSmall,
          )
        ],
      ),
    );
  }
}
