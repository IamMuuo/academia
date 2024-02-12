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
              ? Theme.of(context).primaryColorDark
              : Theme.of(context).primaryColorLight,
        ),
        indicatorStyle: IndicatorStyle(
          width: 40,
          color: isPast
              ? Theme.of(context).primaryColorDark
              : Theme.of(context).primaryColorLight,
          iconStyle: isPast
              ? IconStyle(
                  iconData: Icons.done,
                  color: Colors.white,
                )
              : IconStyle(
                  iconData: Icons.toll,
                  color: Theme.of(context).primaryColorDark,
                ),
        ),
        endChild: Padding(
          padding: const EdgeInsets.all(12),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              titleTextStyle: normal.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              title: Text(title.title()),
              subtitle: Text(
                content,
                style: normal.copyWith(color: Colors.grey[300]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
