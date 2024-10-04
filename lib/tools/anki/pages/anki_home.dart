import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:get/get.dart';
import './empty_anki_home_screen.dart';
import './populated_anki_home_screen.dart';
import './create_topic_form.dart';

class AnkiHomePage extends StatelessWidget {
  const AnkiHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // topic controller
    final TopicController topicController = Get.put(TopicController());
    //  putting ankicard controller
    Get.put(AnkiCardController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            snap: true,
            pinned: true,
            floating: true,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("Anki"),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: "Academia Help",
                    content: const Text(
                      "Mark a topic as your favorite for easy access by tapping the star icon.\nTap on the cards to view their corresponding Anki cards.",
                    ),
                  );
                },
                icon: const Icon(Ionicons.help),
              ),
            ],
          ),
          SliverFillRemaining(
            child: Obx(
              () => topicController.allTopics.isEmpty
                  ? const EmptyAnkiHomeScreen()
                  : const PopulatedAnkiHomeScreen(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const CreateTopicForm(),
            ),
          );
        },
        child: const Icon(Ionicons.add),
      ),
    );
  }
}
