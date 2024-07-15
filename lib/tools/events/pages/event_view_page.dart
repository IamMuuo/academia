import 'package:academia/exports/barrel.dart';
import '../models/models.dart';

class EventViewPage extends StatelessWidget {
  EventViewPage({
    super.key,
    required this.event,
  });
  final Event event;
  final EventsService es = EventsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.only(bottom: 12),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                event.name,
              ),
              expandedHeight: 250,
              snap: true,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl: event.media,
                  fit: BoxFit.cover,
                  errorWidget: (context, error, child) => Container(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "Event Information",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Ionicons.heart),
                    title: const Text("Likes"),
                    subtitle: Text(event.likes.toString()),
                    subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  ListTile(
                    leading: const Icon(Ionicons.mail),
                    title: const Text("Contact Email"),
                    subtitle: Text(event.email),
                    subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  ListTile(
                    leading: const Icon(Ionicons.phone_portrait),
                    title: const Text("Contact Phone"),
                    subtitle: Text(event.phone),
                    subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  ListTile(
                    leading: const Icon(Ionicons.compass),
                    title: const Text("Location"),
                    subtitle: Text(event.location),
                    subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  ListTile(
                    leading: const Icon(Ionicons.today),
                    title: const Text("Starts"),
                    subtitle: Text(formatDateTime(event.startDate)),
                    subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                  ListTile(
                    leading: const Icon(Ionicons.calendar),
                    title: const Text("Ends"),
                    subtitle: Text(formatDateTime(event.endDate)),
                    subtitleTextStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverFillRemaining(
                hasScrollBody: true,
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Event Description",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      event.description,
                      textAlign: TextAlign.justify,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
