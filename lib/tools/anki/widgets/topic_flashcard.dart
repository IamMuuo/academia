import 'package:academia/tools/anki/widgets/eclipses.dart';
import 'package:academia/exports/barrel.dart';

class FlashCardTile extends StatelessWidget {
  const FlashCardTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xff444c55),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: ListTile(
          leading: CustomMixEclipse(),
          title: Text("A computer is a programmable..."),
          dense: false,
          trailing: Icon(
            Icons.edit_note,
          ),
        ),
      ),
    );
  }
}

var list_cards = const [
  FlashCardTile(),
  FlashCardTile(),
  FlashCardTile(),
  FlashCardTile(),
  FlashCardTile(),
  FlashCardTile(),
  FlashCardTile(),
  FlashCardTile(),
  FlashCardTile(),
  FlashCardTile(),
  FlashCardTile(),
  FlashCardTile(),
  FlashCardTile(),
  FlashCardTile(),
  FlashCardTile(),
];
