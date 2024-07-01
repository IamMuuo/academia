import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import '../models/models.dart';

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
                "Fetching awesome events",
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

class EventCard extends StatefulWidget {
  const EventCard({
    super.key,
    required this.event,
  });
  final Event event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  int likes = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      likes = widget.event.likes;
    });
  }

  Future<void> like() async {}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 2,
        horizontal: 0,
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: const AssetImage("assets/icons/academia.png"),
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              ),
              const SizedBox(width: 4),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    widget.event.email,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Ionicons.bulb_outline),
              )
            ],
          ),
          const SizedBox(height: 4),
          CachedNetworkImage(
            imageUrl: widget.event.media,
            height: 300,
            fit: BoxFit.fill,
            errorWidget: (context, str, error) => Container(
              color: Theme.of(context).colorScheme.tertiaryContainer,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Tap to view more",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Ionicons.heart_outline),
              ),
              Text("${widget.event.likes} Likes "),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Ionicons.bookmark_outline,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
