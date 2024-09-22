import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:academia/tools/anki/models/ankicard_model.dart';
import 'package:academia/tools/anki/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditAnkiCard extends StatefulWidget {
  const EditAnkiCard({
    super.key,
    required this.ankiCard,
  });

  final AnkiCard ankiCard;

  @override
  State<EditAnkiCard> createState() => _EditAnkiCardState();
}

class _EditAnkiCardState extends State<EditAnkiCard> {
  bool editQuestion = false;
  bool editAnswer = false;
  // true when the user is highlighting answer otherwise false
  bool switchToWriting = false;
  bool showAnswer = false;
  late TextEditingController questionController;
  late TextEditingController ansController;
  late AnkiCardController ankiCardController;

  @override
  void initState() {
    // intializing controllers
    ankiCardController = Get.find<AnkiCardController>();
    questionController = TextEditingController();
    ansController = TextEditingController();
    // setting the correct value for switchToWriting
    if (widget.ankiCard.question.contains("_")) {
      switchToWriting = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Anki Card",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                switchToWriting = !switchToWriting;
                // setting all enable edits to false
                editAnswer = false;
                editQuestion = false;
              });
            },
            child: Text(
              "Switch to ${switchToWriting ? "Writing" : "Highlighting"}",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Question",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    controller: questionController,
                    enabled: editQuestion,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: widget.ankiCard.question,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onTapOutside: (event) {
                      // checks whether user has highlighted new answers
                      if (switchToWriting &&
                          questionController.selection
                              .textInside(questionController.text)
                              .trim()
                              .isNotEmpty) {
                        setState(() {
                          // remove previous _
                          widget.ankiCard.question = widget.ankiCard.question
                              .replaceAll("_", widget.ankiCard.answer);
                          // changing answer
                          widget.ankiCard.answer = questionController.selection
                              .textInside(questionController.text);
                          // changing question
                          widget.ankiCard.question = widget.ankiCard.question
                              .replaceAll(widget.ankiCard.answer, "_");
                        });
                      }
                    },
                  ),
                ),
                TextButton(
                    onPressed: () {
                      setState(() {
                        editQuestion = true;
                        // setting the text
                        if (widget.ankiCard.question.contains("_")) {
                          // answer was highlited
                          String newQuiz = widget.ankiCard.question
                              .replaceAll("_", widget.ankiCard.answer);
                          questionController.text = newQuiz;
                        } else {
                          questionController.text = widget.ankiCard.question;
                        }
                      });
                    },
                    child: const Text("Edit"))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Answer",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: !switchToWriting
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: TextField(
                          controller: ansController,
                          enabled: editAnswer,
                          decoration: InputDecoration(
                            hintText: widget.ankiCard.answer,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onTapOutside: (event) {
                            // user has typed new answer
                            if (ansController.text.trim().isNotEmpty) {
                              setState(() {
                                widget.ankiCard.answer = ansController.text;
                              });
                            }
                          },
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              editAnswer = true;
                            });
                          },
                          child: const Text("Edit"))
                    ],
                  )
                : TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: widget.ankiCard.answer,
                    ),
                  ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    // updating anki card
                    await ankiCardController.updateAnkiCard(widget.ankiCard);
                    await ankiCardController.getAllTopicCards();
                    if (!mounted) return;
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Card Successfully editted"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  },
                  child: const Text("Update"),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PreviewAnkiCard(ankiCard: widget.ankiCard);
                    },
                  );
                },
                child: const Text("Preview"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
