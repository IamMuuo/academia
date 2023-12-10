import 'package:academia/constants/common.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ToolCard extends StatefulWidget {
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
  State<ToolCard> createState() => _ToolCardState();
}

class _ToolCardState extends State<ToolCard> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.backGround ?? Colors.blueAccent,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.icon ??
                    const Icon(
                      CupertinoIcons.hammer_fill,
                      color: Colors.white,
                    ),
                isLoading
                    ? LoadingAnimationWidget.hexagonDots(
                        size: 20, color: Colors.white)
                    : IconButton(
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await widget.ontap();
                          setState(() {
                            isLoading = false;
                          });
                        },
                        icon: const Icon(
                          CupertinoIcons.arrow_right_circle,
                          color: Colors.white,
                        ),
                      ),
              ],
            ),
            Text(
              widget.title,
              style: widget.titlestyle ??
                  h6.copyWith(
                    fontSize: 14,
                    color: Colors.white,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
