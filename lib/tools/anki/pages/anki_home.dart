import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/models/models.dart';
import 'package:academia/tools/anki/widgets/widgets.dart';
import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AnkiHomePage extends StatelessWidget {
  const AnkiHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // topic controller
    final TopicController topicController = Get.put(TopicController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => topicController.allTopics.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/lotties/study.json",
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Your anki space is a clean slate! 📝 Create your first topic and let Academia Anki help you ace those grades!",
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CreateTopicWidget(
                    topicController: topicController,
                  )
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Starred Topics",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.27,
                      width: MediaQuery.of(context).size.width * 0.87,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, idx) {
                          return StarredTopics(
                            topic: topicController.allFavourites[idx].name,
                            desc: topicController.allFavourites[idx].desc,
                          );
                        },
                        itemCount: topicController.allFavourites.length,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CreateTopicWidget(
                        topicController: topicController,
                      ),
                    ),
                  ),
                  // displays topicics
                  // displayed in a grid view if they are more than five
                  topicController.allTopics.length <= 5
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.35,
                              child: Lottie.asset(
                                "assets/lotties/empty.json",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Once you have more than five topics, they’ll pop into a cool grid view! Don’t forget to star your favorites for quick access—but heads up, you can only star five at a time. If you add a new one, the oldest star gets bumped! ⭐",
                                style: Theme.of(context).textTheme.titleSmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.53,
                          decoration: BoxDecoration(
                            color: lightColorScheme.primaryContainer,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(28),
                              topRight: Radius.circular(28),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, idx) {
                                return GridViewTopic(
                                  idx: idx,
                                  topic: topicController.allTopics[idx].name,
                                  topicDesc:
                                      topicController.allTopics[idx].desc,
                                );
                              },
                              itemCount: topicController.allTopics.length,
                              scrollDirection: Axis.vertical,
                            ),
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}

// widget for creating a topic
class CreateTopicWidget extends StatelessWidget {
  const CreateTopicWidget({
    super.key,
    required this.topicController,
  });

  final TopicController topicController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            final TextEditingController titleController =
                TextEditingController();
            final TextEditingController descController =
                TextEditingController();
            return AlertDialog(
              title: const Text("Create Topic"),
              content: SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Topic"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 8.0,
                      ),
                      child: TextField(
                        controller: titleController,
                        maxLength: 10,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const Text("Topic Description"),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 0,
                        vertical: 8.0,
                      ),
                      child: TextField(
                        controller: descController,
                        maxLength: 54,
                        maxLines: 2,
                        decoration: InputDecoration(
                          hintText:
                              "This Contains Flash Cards For [Topic Name]",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: lightColorScheme.error),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isEmpty ||
                        descController.text.trim().isEmpty) {
                      // tell user they can't be empty
                      debugPrint("All Above Fields are required");
                    } else if (titleController.text.trim().length <= 3) {
                      // tell user topic length should be greater than 2 characters
                      debugPrint(
                          "Topic Length should be more than 2 characters");
                    } else if (descController.text.trim().length <= 12) {
                      // tell user desc length should be greater than 11 characters
                      debugPrint(
                          "Desc Length should be more than 11 characters");
                    } else {
                      // create topic
                      AnkiTopic ankiTopic = AnkiTopic(
                        name: titleController.text,
                        desc: descController.text,
                      );
                      // add to database
                      if (topicController.numTopics() < 5) {
                        ankiTopic.isFavourite = true;
                      }
                      topicController.addTopic(ankiTopic);

                      if (topicController.numTopics() < 5) {
                        // updating favourites
                        topicController.getAllFavourites();
                      }
                      // updating topic list
                      topicController.getAllTopics();
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("create"),
                ),
              ],
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        elevation: 0,
      ),
      child: const Text(
        "Create Topic",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
