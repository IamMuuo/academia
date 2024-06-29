import 'package:flutter/material.dart';

Widget circle = Padding(
  padding: const EdgeInsets.all(1.0),
  child: Container(
    width: 15,
    height: 15,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xff444c55),
    ),
  ),
);

class CustomEclipse extends StatelessWidget {
  const CustomEclipse({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Row(
        children: [
          circle,
          circle,
          circle,
        ],
      ),
    );
  }
}
