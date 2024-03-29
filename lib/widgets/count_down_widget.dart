import 'package:academia/exports/barrel.dart';
import 'dart:async';

class CountDown extends StatefulWidget {
  const CountDown({super.key, required this.deadline});
  final DateTime deadline;

  @override
  State<CountDown> createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  Duration duration = const Duration();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _calculateTimeLeft(widget.deadline);

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _calculateTimeLeft(widget.deadline);
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.1,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Time's ticking",
            style: h5.copyWith(color: Theme.of(context).primaryColorLight),
          ),
          const SizedBox(
            height: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Days
              Container(
                width: 70,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  children: [
                    Text(
                      duration.inDays.toString().padLeft(2, "0"),
                      style: h2.copyWith(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    const Text("Days"),
                  ],
                ),
              ),

              // Hours
              Container(
                width: 70,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  children: [
                    Text(
                      (duration.inHours % 24).toString().padLeft(2, "0"),
                      style: h2.copyWith(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    const Text("Hours"),
                  ],
                ),
              ),

              // Minutes
              Container(
                width: 70,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  children: [
                    Text(
                      (duration.inMinutes % 60).toString().padLeft(2, "0"),
                      style: h2.copyWith(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    const Text("Minutes"),
                  ],
                ),
              ),

              // Seconds
              Container(
                width: 70,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: Column(
                  children: [
                    Text(
                      (duration.inSeconds % 60).toString().padLeft(2, "0"),
                      style: h2.copyWith(
                        color: Theme.of(context).primaryColorDark,
                      ),
                    ),
                    const Text("Seconds"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /*
     calculateTimeLeft

     Calculates the time left between the current time and 
     the expected time 
  */
  void _calculateTimeLeft(DateTime deadline) {
    final seconds = deadline.difference(DateTime.now()).inSeconds;
    setState(() {
      duration = seconds >= 0
          ? Duration(seconds: seconds)
          : const Duration(seconds: 0);
    });
  }
}
