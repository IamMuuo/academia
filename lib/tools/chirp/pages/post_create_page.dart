import 'package:academia/exports/barrel.dart';

class PostCreatePage extends StatefulWidget {
  const PostCreatePage({super.key});

  @override
  State<PostCreatePage> createState() => _PostCreatePageState();
}

class _PostCreatePageState extends State<PostCreatePage> {
  final List<String> postLinks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.close),
        ),
        actions: [
          FilledButton(
            onPressed: () {},
            child: const Text("Post"),
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: Column(
          children: [
            TextFormField(
              style: Theme.of(context).textTheme.headlineSmall,
              decoration: InputDecoration(
                hintText: "Title",
                hintStyle: Theme.of(context).textTheme.headlineSmall,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 22),
            TextFormField(
              maxLines: 20,
              decoration: const InputDecoration(
                hintText: "Body Text",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Ionicons.camera),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Ionicons.images),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Ionicons.link_outline),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
