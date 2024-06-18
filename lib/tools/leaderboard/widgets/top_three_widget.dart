import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class LeaderBoardProfileWidget extends StatelessWidget {
  const LeaderBoardProfileWidget({
    super.key,
    required this.position,
    required this.username,
    required this.points,
  });
  final int position;
  final String username;
  final String points;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          position == 1 ? Emojis.clothing_crown : "$position",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const Spacer(),
        CircleAvatar(
          radius: position == 1 ? 40 : 30,
          child: Image.asset("assets/images/male_student.png"),
        ),
        const SizedBox(height: 4),
        Text(
          "@$username",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          "$points points",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
