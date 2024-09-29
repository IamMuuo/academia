import 'package:academia/exports/barrel.dart';
import 'package:story_view/story_view.dart';

class StoryViewPage extends StatefulWidget {
  const StoryViewPage({
    super.key,
    required this.organization,
    required this.stories,
  });

  final Organization organization;
  final List<Story> stories;

  @override
  State<StoryViewPage> createState() => _StoryViewPageState();
}

class _StoryViewPageState extends State<StoryViewPage> {
  final StoryController _storyController = StoryController();

  List<StoryItem> buildStoryItems(List<Story> stories) {
    List<StoryItem> storyItems = [];
    for (final story in stories) {
      switch (story.fileType) {
        case "image":
          storyItems.add(
            StoryItem.pageImage(
              url: "${ChirpService.urlPrefix}${story.media}",
              controller: _storyController,
              caption: Text(
                story.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              loadingWidget: const CircularProgressIndicator.adaptive(),
            ),
          );

          break;
        case "video":
          storyItems.add(
            StoryItem.pageVideo(
              "${ChirpService.urlPrefix}${story.media}",
              controller: _storyController,
              caption: Text(
                story.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
              ),
              loadingWidget: const CircularProgressIndicator.adaptive(),
            ),
          );
          break;

        case "text":
          storyItems.add(
            StoryItem.text(
                title: story.description,
                backgroundColor:
                    Theme.of(context).colorScheme.tertiaryContainer),
          );
          break;

        default:
      }
    }

    return storyItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(
                widget.organization.logo!,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              widget.organization.name,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ],
        ),
      ),
      body: StoryView(
        repeat: false,
        onComplete: () {
          Navigator.pop(context);
        },
        indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
        indicatorForegroundColor: Theme.of(context).primaryColor,
        storyItems: buildStoryItems(widget.stories),
        controller: _storyController,
      ),
    );
  }
}
