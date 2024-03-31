import 'package:academia/exports/barrel.dart';

class Stat extends StatelessWidget {
  const Stat({
    super.key,
    required this.title,
    required this.percentage,
  });
  final String title;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: CircularPercentIndicator(
        header: Text(title),
        center: Text("${(percentage * 100).toStringAsPrecision(2)}%"),
        curve: Curves.elasticIn,
        lineWidth: 12,
        animation: true,
        percent: percentage,
        startAngle: 40,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        progressColor: Theme.of(context).colorScheme.primary,
        animationDuration: 2000,
        animateFromLastPercent: true,
        radius: 40,
      ),
    );
  }
}
