import 'package:academia/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/models.dart';
import '../widgets/widgets.dart';
import 'package:lottie/lottie.dart';

class LikedEventsPage extends StatelessWidget {
  LikedEventsPage({super.key});

  final EventsService es = EventsService();
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: es.fetchLikedEvents(userController.user.value!.id!),
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
          return r.isEmpty
              ? Column(
                  children: [
                    Lottie.asset("assets/lotties/empty.json"),
                    const SizedBox(height: 12),
                    Text(
                      "Like an event to see it here",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    final event = r[index];
                    return EventCard(event: event);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 2),
                  itemCount: r.length,
                );
        });
      },
    );
  }
}
