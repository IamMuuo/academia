import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/widgets/widgets.dart';
import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AnkiHomePage extends StatelessWidget {
  const AnkiHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // topic controller
    TopicController topicController = Get.put(TopicController());

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
                  const CreateTopicWidget()
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
                          return listStarred[idx];
                        },
                        itemCount: 5,
                      ),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CreateTopicWidget(),
                    ),
                  ),
                  Container(
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
                          return test_topics[idx];
                        },
                        itemCount: test_topics.length,
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
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            final TextEditingController topicController =
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
                        controller: topicController,
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
                    if (topicController.text.isEmpty ||
                        descController.text.isEmpty) {
                      // tell user they can't be empty
                      debugPrint("All Above Fields are required");
                    } else if (topicController.text.trim().length <= 3) {
                      // tell user topic length should be greater than 2 characters
                      debugPrint(
                          "Topic Length should be more than 2 characters");
                    } else if (descController.text.trim().length <= 12) {
                      // tell user desc length should be greater than 11 characters
                      debugPrint(
                          "Desc Length should be more than 11 characters");
                    } else {
                      debugPrint("Feature Coming Soon");
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
