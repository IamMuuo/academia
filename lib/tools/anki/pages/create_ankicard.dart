import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:academia/tools/anki/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAnkicard extends StatelessWidget {
  const CreateAnkicard({
    super.key,
    required this.topicId,
  });

  final int topicId;

  @override
  Widget build(BuildContext context) {
    TextEditingController cardInfo = TextEditingController();
    TextEditingController cardAns = TextEditingController();
    AnswerCardController ansCardController = Get.put(AnswerCardController());
    AnkiCardController ankiCardController = Get.find<AnkiCardController>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Create Card"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: cardInfo,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Some question you want to remember",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onTapOutside: (event) {
                ansCardController.ansCard.value =
                    cardInfo.selection.textInside(cardInfo.text);
                cardAns.text = ansCardController.ansCard.value;
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
            () => !ansCardController.ansSwitch.value
                // TextField for Showing Highlighted Answer
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: ansCardController.ansCard.isEmpty
                            ? "Your Answer To be Hidden"
                            : ansCardController.ansCard.value,
                      ),
                    ),
                  )
                // TextField For Writing An Answer
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: cardAns,
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: "Your Answer To be Hidden",
                      ),
                    ),
                  ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
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
                    "Switch To ${!ansCardController.ansSwitch.value ? "Writing" : "Highlight"}",
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () async {
                  // check for user inputs
                  if (cardInfo.text.trim().isEmpty ||
                      cardAns.text.trim().isEmpty) {
                    // tell user that all fields are required
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("All Fields Are Required"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                  // user chose to write the answer
                  else if (ansCardController.ansSwitch.value) {
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
                    await ankiCardController.getAllTopicCards(topicId);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("AnkiCard Created Successfully"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  } else {
                    // remove highlighted answer from the question
                    String question = cardInfo.text.trim();
                    question = question.replaceAll(cardAns.text.trim(), "_");
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
                    await ankiCardController.getAllTopicCards(topicId);

                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("AnkiCard Created Successfully"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
                },
                child: const Text("Create Card"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
