import 'package:academia/exports/barrel.dart';

Widget blackcircle = Padding(
  padding: const EdgeInsets.all(1.0),
  child: Container(
    width: 15,
    height: 15,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xff444c55),
    ),
  ),
);

class CustomEclipse extends StatelessWidget {
  const CustomEclipse({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Row(
        children: [
          blackcircle,
          blackcircle,
          blackcircle,
        ],
      ),
    );
  }
}

class CustomMixEclipse extends StatelessWidget {
  const CustomMixEclipse({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
