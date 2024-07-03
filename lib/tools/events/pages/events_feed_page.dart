import 'package:academia/exports/barrel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';

class EventsFeedPage extends StatelessWidget {
  EventsFeedPage({super.key});

  final EventsService es = EventsService();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: es.fetchAllEvents(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Column(
            children: [
              Lottie.asset("assets/lotties/fetching.json"),
              const SizedBox(height: 12),
              Text(
                "Fetching awesome events",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          );
        }
        return snapshot.data!.fold((l) {
          return Column(
            children: [
              Lottie.asset("assets/lotties/error.json"),
              const SizedBox(height: 12),
              Text(
                "Arg snap: $l",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          );
        }, (r) {
          return ListView.separated(
            itemBuilder: (context, index) {
              final event = r[index];
              return EventCard(event: event);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 2),
            itemCount: r.length,
          );
        });
      },
    );
  }
}
