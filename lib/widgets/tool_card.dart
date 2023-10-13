import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToolCard extends StatelessWidget {
  const ToolCard({
    super.key,
    required this.ontap,
    required this.title,
    this.backGround,
    this.icon,
    this.titlestyle,
  });

  final Function ontap;
  final Color? backGround;
  final Icon? icon;
  final String title;
  final TextStyle? titlestyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backGround ?? Colors.blueAccent,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: GestureDetector(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  icon ?? const Icon(CupertinoIcons.hammer_fill, color: Colors.white,),
                  IconButton(
                    onPressed: () {
                      ontap();
                    },
                    icon: const Icon(
                      CupertinoIcons.arrow_right_circle,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Text(
                title,
                style: titlestyle ??
                    const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
