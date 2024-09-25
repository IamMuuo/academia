import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:get/get.dart';
import './empty_anki_home_screen.dart';
import './populated_anki_home_screen.dart';

class AnkiHomePage extends StatelessWidget {
  const AnkiHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // topic controller
    final TopicController topicController = Get.put(TopicController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            expandedHeight: 250,
            snap: true,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Anki"),
            ),
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
    );
  }
}
