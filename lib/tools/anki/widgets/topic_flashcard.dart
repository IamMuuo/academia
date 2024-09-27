import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:academia/tools/anki/models/ankicard_model.dart';
import 'package:academia/tools/anki/pages/edit_anki_card.dart';
import 'package:academia/tools/anki/widgets/eclipses.dart';
import 'package:academia/tools/anki/widgets/preview_card.dart';
import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class FlashCardTile extends StatelessWidget {
  const FlashCardTile({
    super.key,
    required this.ankiCard,
  });

  final AnkiCard ankiCard;

  @override
  Widget build(BuildContext context) {
    AnkiCardController ankiCardController = Get.find<AnkiCardController>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return PreviewAnkiCard(ankiCard: ankiCard);
            },
          );
        },
        onDoubleTap: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: const Text(
                "Are You Sure You Want To Delete AnkiCard?",
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    bool? deleted =
                        await ankiCardController.deleteCard(ankiCard);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: deleted
                            ? const Text("AnkiCard Successfully Deleted")
                            : const Text("Something happened! Kindly Retry!!"),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                    // update favourites and all topics
                    await ankiCardController.getAllTopicCards();
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yes"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No"),
                ),
              ],
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color(0xff444c55),
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: ListTile(
            leading: const CustomMixEclipse(),
            title: ankiCard.question.length > 31
                ? Text(
                    "${ankiCard.question.substring(0, 29)}...",
                  )
                : Text("${ankiCard.question}..."),
            dense: false,
            trailing: IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => EditAnkiCard(
                    ankiCard: ankiCard,
                  ),
                ),
              ),
              icon: const Icon(
                Icons.edit_note,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
