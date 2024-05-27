import 'package:academia/exports/barrel.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCard extends StatelessWidget {
  const PostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const CircleAvatar(
                child: ProfilePictureWidget(
                  profileSize: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "@DITA",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w800, color: Colors.grey),
                    ),
                    Text(
                      "20 mins ago",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Ionicons.ellipsis_horizontal_circle_outline),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Introducing the new academia 1.0",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                trimTo99Characters(
                    "Yes, it is possible to host a Go (Golang) project on a server, including one hosted on platforms like serv00. The exact steps may vary depending on the specific details of your server environment and your project requirements, but here are the general steps you would follow:"),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Row(
                  children: [
                    const Icon(
                      Ionicons.arrow_up_circle_outline,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "1081",
                      style: GoogleFonts.ubuntu(),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () {},
                icon: const Icon(Ionicons.arrow_down_circle_outline),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Ionicons.arrow_redo_outline),
              )
            ],
          )
        ],
      ),
    );
  }

  String trimTo99Characters(String text) {
    if (text.length <= 99) {
      return text;
    } else {
      return '${text.substring(0, 96)}...';
    }
  }
}
