import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/anki/models/models.dart';

class PreviewAnkiCard extends StatefulWidget {
  const PreviewAnkiCard({
    super.key,
    required this.ankiCard,
  });

  final AnkiCard ankiCard;

  @override
  State<PreviewAnkiCard> createState() => _PreviewAnkiCardState();
}

class _PreviewAnkiCardState extends State<PreviewAnkiCard> {
  bool showAnswer = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Anki Card Preview",
      ),
      content: IntrinsicHeight(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Question",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.ankiCard.question,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    showAnswer = !showAnswer;
                  });
                },
                child: showAnswer
                    ? const Text(
                        "hide answer",
                      )
                    : const Text(
                        "show answer",
                      ),
              ),
            ),
            showAnswer
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.ankiCard.answer,
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
