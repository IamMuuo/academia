import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/models/ankicard_model.dart';
import 'package:academia/tools/anki/widgets/widgets.dart';
import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class TopicFlashCards extends StatelessWidget {
  const TopicFlashCards({
    super.key,
    required this.topicId,
  });

  final int topicId;

  @override
  Widget build(BuildContext context) {
    // adding AnkiCardController
    AnkiCardController ankiCardController = Get.put(
      AnkiCardController(
        topicId: topicId,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.height * 0.17,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // add card button
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    TextEditingController cardInfo = TextEditingController();
                    TextEditingController cardAns = TextEditingController();
                    AnswerCardController ansCardController =
                        Get.put(AnswerCardController());

                    return AlertDialog(
                      title: const Text(
                        "Create Card",
                      ),
                      content: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.45,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: cardInfo,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onTapOutside: (event) {
                                  ansCardController.ansCard.value = cardInfo
                                      .selection
                                      .textInside(cardInfo.text);
                                  cardAns.text =
                                      ansCardController.ansCard.value;
                                },
                              ),
                            ),
                            Obx(
                              () => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ansCardController.ansSwitch.value
                                    ? const Text(
                                        "Selected Answer",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : const Text(
                                        "Type Answer",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
                            ),
                            Obx(
                              () => ansCardController.ansSwitch.value
                                  // TextField for Showing Highlighted Answer
                                  ? TextField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        hintText: ansCardController
                                                .ansCard.isEmpty
                                            ? "Your Answer To be Hidden"
                                            : ansCardController.ansCard.value,
                                      ),
                                    )
                                  // TextField For Writing An Answer
                                  : TextField(
                                      controller: cardAns,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        hintText: "Your Answer To be Hidden",
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              ansCardController.ansSwitch.value =
                                  !ansCardController.ansSwitch.value;
                              // clearing the text fields
                              cardInfo.clear();
                              cardAns.clear();
                              ansCardController.ansCard.value = "";
                            },
                            child: Obx(
                              () => Text(
                                "Switch To ${ansCardController.ansSwitch.value ? "Writing" : "Highlight"}",
                              ),
                            ),
                          ),
                        ),
                        // buttom to create card
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () async {
                              // check for user inputs
                              if (cardInfo.text.trim().isEmpty ||
                                  cardAns.text.trim().isEmpty) {
                                // tell user that all fields are required
                                debugPrint("All Fields Are Required");
                              }
                              // user chose to write the answer
                              else if (!ansCardController.ansSwitch.value) {
                                AnkiCard ankiCard = AnkiCard(
                                    topicId: topicId,
                                    question: cardInfo.text.trim(),
                                    answer: cardAns.text.trim());
                                await ankiCardController.addAnkiCard(ankiCard);
                                // clearing the text fields
                                cardInfo.clear();
                                cardAns.clear();
                                ansCardController.ansCard.value = "";
                                // reload the anki cards
                                await ankiCardController.getAllTopicCards();
                                // tell user the card is successfully added
                              } else {
                                // remove highlighted answer from the question
                                String question = cardInfo.text.trim();
                                question = question.replaceAll(
                                    cardAns.text.trim(), "_");
                                AnkiCard ankiCard = AnkiCard(
                                    topicId: topicId,
                                    question: question,
                                    answer: cardAns.text.trim());
                                await ankiCardController.addAnkiCard(ankiCard);
                                // clearing the text fields
                                cardInfo.clear();
                                cardAns.clear();
                                ansCardController.ansCard.value = "";
                                // reload the anki cards
                                await ankiCardController.getAllTopicCards();
                                // tell user the card is successfully added
                              }
                            },
                            child: const Text("Create Card"),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            style: ElevatedButton.styleFrom(
                                foregroundColor: lightColorScheme.error),
                            child: const Text("Cancel"),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Icon(Icons.add),
            ),
            const Spacer(),
            // play cards button
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                debugPrint("Feature Coming Soon");
              },
              child: const Icon(Icons.play_arrow),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.30,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.37,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0),
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.37,
                          decoration: const BoxDecoration(
                            color: Color(0xffe5ffcd),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 8,
                                  top: 8,
                                ),
                                child: Text(
                                  "Number Of",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 8,
                                ),
                                child: Text(
                                  "Cards",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            height: MediaQuery.of(context).size.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.37,
                            decoration: const BoxDecoration(
                              color: Color(0xffe5ffcd),
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "1000",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    width: MediaQuery.of(context).size.width * 0.54,
                    child: Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(0),
                          height: MediaQuery.of(context).size.height * 0.12,
                          width: MediaQuery.of(context).size.width * 0.54,
                          decoration: const BoxDecoration(
                            color: Color(0xffffe7cd),
                            borderRadius: BorderRadius.all(
                              Radius.circular(21),
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 8,
                                  top: 8,
                                ),
                                child: Text(
                                  "Good",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 8,
                                ),
                                child: Text(
                                  "Frequencies",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          child: Container(
                            padding: const EdgeInsets.all(0),
                            height: MediaQuery.of(context).size.height * 0.09,
                            width: MediaQuery.of(context).size.width * 0.54,
                            decoration: const BoxDecoration(
                              color: Color(0xffffe7cd),
                              borderRadius: BorderRadius.all(
                                Radius.circular(21),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "1000",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "All Flash Cards",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Obx(
            () => ankiCardController.allCards.isEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.64,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Lottie.asset(
                              "assets/lotties/study.json",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Your card deck is blank! 🎴",
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Add your first card to start",
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "mastering your topics!",
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.64,
                    child: ListView.builder(
                      itemBuilder: (context, idx) {
                        return FlashCardTile(
                          ankiCard: ankiCardController.allCards[idx],
                        );
                      },
                      itemCount: ankiCardController.allCards.length,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
