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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: SizedBox(
          height: MediaQuery.of(context).size.height * 0.17,
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.26,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.24,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                width: MediaQuery.of(context).size.width * 0.37,
                                decoration: const BoxDecoration(
                                  color: Color(0xffe5ffcd),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Obx(
                                    () => Text(
                                      "${ankiCardController.allCards.length}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.24,
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
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 0.0,
              ),
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
      ),
    );
  }
}
