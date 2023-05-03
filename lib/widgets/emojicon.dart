import 'package:flutter/material.dart';

class Emojicon extends StatefulWidget {
  const Emojicon({super.key});

  @override
  State<Emojicon> createState() => _EmojiconState();
}

class _EmojiconState extends State<Emojicon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue[400],
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Image.asset(
        'assets/images/drool.png',
        scale: 2,
        height: 55,
        width: 55,
      ),
    );
  }
}
