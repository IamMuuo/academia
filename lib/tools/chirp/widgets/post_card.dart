import 'package:academia/exports/barrel.dart';
import 'package:google_fonts/google_fonts.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
  });
  final Post post;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
                      "@${post.username}",
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
                post.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                trimTo99Characters(post.content),
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
                      post.upvotes.toString(),
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
}
