import 'package:academia/tools/anki/models/ankicard_model.dart';
import 'package:academia/tools/anki/pages/edit_anki_card.dart';
import 'package:academia/tools/anki/widgets/eclipses.dart';
import 'package:academia/exports/barrel.dart';

class FlashCardTile extends StatelessWidget {
  const FlashCardTile({
    super.key,
    required this.ankiCard,
  });

  final AnkiCard ankiCard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
    );
  }
}
