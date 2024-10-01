import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/pages/anki_swap.dart';
import 'package:academia/tools/anki/pages/create_ankicard.dart';
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Topic flash cards"),
      ),
      floatingActionButton: SizedBox(
        height: MediaQuery.of(context).size.height * 0.18,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // add card button
            FloatingActionButton(
              heroTag: "btn1",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateAnkicard(),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
            const Spacer(),
            // play cards button
            FloatingActionButton(
              heroTag: "btn2",
              onPressed: () {
                if (ankiCardController.allCards.length >= 5) {
                  // opens the anki swap page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AnkiSwap(ankiCards: ankiCardController.allCards),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content:
                          Text("Anki Cards Should be More than 4, To Play"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              child: const Icon(Icons.play_arrow),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
      ),
    );
  }
}
