import 'package:flutter/material.dart';

class Emojicon extends StatefulWidget {
  Emojicon({
    Key? key,
    required this.path,
    required this.func,
  }) : super(key: key);

  final String path;
  final VoidCallback func;

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
      child: IconButton(
        onPressed: widget.func,
        icon: Image.asset(
          widget.path,
          scale: 5,
        ),
      ),
    );
  }
}

List<Emojicon> buildEmojiCons() {
  final emojicons = <Emojicon>[];
  emojicons.add(Emojicon(path: "assets/images/drool.png", func: () {}));
  emojicons.add(Emojicon(path: "assets/images/bored.png", func: () {}));
  emojicons.add(Emojicon(path: "assets/images/smiley.png", func: () {}));
  emojicons.add(Emojicon(path: "assets/images/bored.png", func: () {}));
  return emojicons;
}
