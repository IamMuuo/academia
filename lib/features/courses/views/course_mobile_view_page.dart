import 'package:academia/database/database.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sliver_tools/sliver_tools.dart';

class CourseMobileViewPage extends StatefulWidget {
  const CourseMobileViewPage({
    super.key,
    required this.course,
  });

  final CourseData course;
  @override
  State<CourseMobileViewPage> createState() => _CourseMobileViewPageState();
}

class _CourseMobileViewPageState extends State<CourseMobileViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            expandedHeight: 128,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(widget.course.unit),
            ),

            // actions
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Bootstrap.trash),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: MultiSliver(
              children: [
                SliverPinnedHeader(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Course Details",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),

                // Graph
                SliverList.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      child: Text(index.toString()),
                    ),
                    title: Text("Hi"),
                    subtitle: Text("Some really nice content"),
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: MultiSliver(
              children: [
                SliverPinnedHeader(
                  child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      "Course Details",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                ),

                // Information cards
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(Bootstrap.hash),
                    title: const Text("Course Unit Code"),
                    subtitle: Text(widget.course.unit),
                  ),
                ),
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.zero,
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(Bootstrap.nut),
                    title: const Text("Course Section"),
                    subtitle: Text(widget.course.section),
                  ),
                ),
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.zero,
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(Bootstrap.person_badge),
                    title: const Text("Lecturer"),
                    subtitle: Text(widget.course.lecturer),
                  ),
                ),

                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.zero,
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(Bootstrap.calendar2_date),
                    title: const Text("Every"),
                    subtitle: Text(widget.course.weekDay),
                  ),
                ),

                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.zero,
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(Bootstrap.clock),
                    title: const Text("Period"),
                    subtitle: Text(widget.course.period),
                  ),
                ),
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(bottom: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(Bootstrap.house_check),
                    title: const Text("Venue"),
                    subtitle: Text(widget.course.room),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("New Reminder"),
        icon: const Icon(Bootstrap.alarm),
      ),
    );
  }
}
