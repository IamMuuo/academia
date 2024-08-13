import 'package:academia/exports/barrel.dart';

class LeaderBoardProfileWidget extends StatelessWidget {
  const LeaderBoardProfileWidget({
    super.key,
    required this.position,
    required this.username,
    required this.points,
    required this.profileUrl,
    this.gender = "male",
  });
  final int position;
  final String username;
  final String points;
  final String profileUrl;
  final String gender;

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
            child: profileUrl.startsWith("http")
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: CachedNetworkImage(
                      imageUrl: profileUrl,
                      fit: BoxFit.fill,
                    ),
                  )
                : gender == "male"
                    ? Image.asset("assets/images/male_student.png")
                    : Image.asset("assets/images/female_student.png")),
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
