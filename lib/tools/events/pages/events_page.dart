import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'events_feed_page.dart';
import 'liked_events_page.dart';
import 'semester_page.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage>
    with AutomaticKeepAliveClientMixin<EventsPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Events",
            style: GoogleFonts.oleoScript(),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: "All Events"),
              Tab(text: "Timeline"),
              Tab(text: "Liked Events"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EventsFeedPage(),
            SemesterPage(),
            LikedEventsPage(),
          ],
        ),
      ),
    );
  }
}
