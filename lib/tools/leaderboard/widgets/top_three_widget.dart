import 'package:academia/exports/barrel.dart';
import 'package:academia/models/models.dart';

class LeaderBoardProfileWidget extends StatelessWidget {
  const LeaderBoardProfileWidget({
    super.key,
    required this.position,
    required this.user,
  });
  final int position;
  final User user;

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
          "@erick",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          "200 points",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
