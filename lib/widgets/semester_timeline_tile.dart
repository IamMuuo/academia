import 'package:academia/exports/barrel.dart';
import 'package:timeline_tile/timeline_tile.dart';

class SemesterTimeLineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final String title;
  final String content;
  const SemesterTimeLineTile({
    super.key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 150,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        beforeLineStyle: LineStyle(
          color: isPast
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.tertiary,
        ),
        indicatorStyle: IndicatorStyle(
          width: 40,
          color: isPast
              ? Theme.of(context).colorScheme.secondary
              : Theme.of(context).colorScheme.tertiary,
          iconStyle: isPast
              ? IconStyle(iconData: Icons.check)
              : IconStyle(iconData: Icons.alarm_sharp),
        ),
        endChild: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              titleTextStyle: Theme.of(context).textTheme.titleMedium,
              title: Text(title.title()),
              subtitle: Text(
                content,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
