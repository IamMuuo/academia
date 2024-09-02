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
        footer: Text(title),
        center: Text("${(percentage * 100).toStringAsFixed(1)}%"),
        curve: Curves.elasticIn,
        lineWidth: 18,
        animation: true,
        percent: percentage,
        startAngle: 40,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        progressColor: Theme.of(context).colorScheme.primary,
        animationDuration: 2000,
        animateFromLastPercent: true,
        radius: 40,
      ),
    );
  }
}
