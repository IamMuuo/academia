import 'package:academia/tools/anki/models/ankicard_model.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:flutter/material.dart';

class AnkiSwap extends StatefulWidget {
  const AnkiSwap({
    super.key,
    required this.ankiCards,
  });

  final List<AnkiCard> ankiCards;

  @override
  State<AnkiSwap> createState() => _AnkiSwapState();
}

class _AnkiSwapState extends State<AnkiSwap> {
  // holds the mutable list
  List<AnkiCard> cards = [];
  bool showAnswer = false;
  final AppinioSwiperController controller = AppinioSwiperController();

  @override
  void initState() {
    cards.clear();
    cards.addAll(widget.ankiCards);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          "Academia Anki",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Double Tap To Show Answer"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: AppinioSwiper(
                  backgroundCardOffset: Offset.zero,
                  backgroundCardCount: 0,
                  allowUnSwipe: false,
                  onSwipeBegin: (previousIndex, targetIndex, activity) {
                    setState(() {
                      showAnswer = false;
                    });
                    if (activity.direction == AxisDirection.left) {
                      cards.insert(targetIndex + 2, cards[previousIndex]);
                    } else {
                      cards.add(cards[previousIndex]);
                    }
                  },
                  maxAngle: 60,
                  swipeOptions: const SwipeOptions.symmetric(horizontal: true),
                  cardCount: cards.length,
                  cardBuilder: (context, index) {
                    var colorDet = index % 4;
                    return GestureDetector(
                      onDoubleTap: () {
                        setState(() {
                          showAnswer = true;
                        });
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.45,
                        decoration: BoxDecoration(
                          color: colorDet == 0
                              ? Theme.of(context).colorScheme.primaryContainer
                              : colorDet == 1
                                  ? Theme.of(context)
                                      .colorScheme
                                      .secondaryContainer
                                  : colorDet == 2
                                      ? Theme.of(context)
                                          .colorScheme
                                          .tertiaryContainer
                                      : Theme.of(context)
                                          .colorScheme
                                          .errorContainer,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const Text(
                                "Question",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                cards[index].question,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              const Text(
                                "Answer",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              showAnswer
                                  ? Text(
                                      cards[index].answer,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/left_arrow.png",
                      height: 70,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("If Good"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("If Bad"),
                    ),
                    Image.asset(
                      "assets/images/right_arrow.png",
                      height: 70,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
