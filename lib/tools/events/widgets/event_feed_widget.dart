import 'package:academia/controllers/controllers.dart';
import 'package:academia/pages/util_pages/webview_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/models.dart';
import '../pages/event_view_page.dart';

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
  final userController = Get.find<UserController>();
  final EventsService es = EventsService();
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EventViewPage(
                  event: widget.event,
                )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 2,
          horizontal: 0,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  child: Icon(
                    Ionicons.at_circle_outline,
                  ),
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
                  icon: const Icon(Ionicons.arrow_redo_outline),
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
                FutureBuilder(
                  future: es.isEventLikedByUser(
                      userController.user.value!.id!, widget.event.id),
                  builder: (context, snapshot) {
                    return IconButton(
                      onPressed:
                          snapshot.connectionState != ConnectionState.done
                              ? null
                              : () async {
                                  es
                                      .likeEvent(
                                    userController.user.value!.id!,
                                    widget.event.id,
                                    false,
                                  )
                                      .then((value) {
                                    value.fold((l) {
                                      setState(() {
                                        likes--;
                                      });
                                    }, (r) {
                                      setState(() {
                                        if (r) {
                                          likes++;
                                        } else {
                                          likes--;
                                        }
                                      });
                                    });
                                  });
                                },
                      icon: Icon(
                        Ionicons.heart_outline,
                        color: snapshot.data?.fold((l) {
                          return null;
                        }, (r) {
                          if (r) {
                            return Colors.red;
                          }
                          return null;
                        }),
                      ),
                    );
                  },
                ),
                Text("$likes Likes "),
                const Spacer(),
                Visibility(
                  visible: widget.event.url != null,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => WebviewPage(
                            title: "More about Event",
                            url: widget.event.url!,
                          ),
                        ),
                      );
                    },
                    child: const Text("More"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
