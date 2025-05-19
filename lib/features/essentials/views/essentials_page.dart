import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vibration/vibration.dart';

class EssentialsPage extends StatefulWidget {
  const EssentialsPage({super.key});

  @override
  State<EssentialsPage> createState() => _EssentialsPageState();
}

class _EssentialsPageState extends State<EssentialsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/icons/academia_ghibli.png",
                fit: BoxFit.cover,
              ),
              title: Text(
                "Essentials",
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: MultiSliver(
              children: [
                Card(
                  margin: EdgeInsets.only(bottom: 2),
                  elevation: 0,
                  color: Theme.of(context)
                      .colorScheme
                      .tertiaryContainer
                      .withAlpha(100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: ListTile(
                    onTap: () async {
                      context.pushNamed(
                        "fees",
                      );
                      if (await Vibration.hasVibrator()) {
                        await Vibration.vibrate(
                          duration: 32,
                          sharpness: 250,
                        );
                      }
                    },
                    leading: Icon(Clarity.coin_bag_line),
                    title: Text("School Fees"),
                    subtitle: Text("Keep track of your finances"),
                  ),
                ),

                Card(
                  margin: EdgeInsets.only(bottom: 2),
                  elevation: 0,
                  color: Theme.of(context)
                      .colorScheme
                      .tertiaryContainer
                      .withAlpha(100),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  child: ListTile(
                    onTap: () async {
                      context.pushNamed(
                        "performance-metric-view",
                        extra: PerformanceMetricType.audit,
                      );
                      if (await Vibration.hasVibrator()) {
                        await Vibration.vibrate(
                          duration: 32,
                          sharpness: 250,
                        );
                      }
                    },
                    leading: const Icon(Clarity.heart_broken_line),
                    title: Text("Student Audit"),
                    subtitle: Text("Get to know how well you're fairing"),
                  ),
                ),

                Card(
                  elevation: 0,
                  color: Theme.of(context)
                      .colorScheme
                      .tertiaryContainer
                      .withAlpha(100),
                  margin: const EdgeInsets.only(bottom: 2),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                  ),
                  child: ListTile(
                    onTap: () async {
                      final Uri url =
                          Uri.parse('https://elearning.daystar.ac.ke/');
                      if (!await launchUrl(url)) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                            "We ran into an issue. This event has been recorded",
                          )),
                        );
                      }
                    },
                    leading: const Icon(Clarity.pinboard_line),
                    title: const Text("Elearning"),
                    subtitle: const Text("Never miss an assignment or CAT"),
                  ),
                ),
                //Card(
                //  elevation: 0,
                //  color: Theme.of(context)
                //      .colorScheme
                //      .tertiaryContainer
                //      .withAlpha(100),
                //  margin: EdgeInsets.only(bottom: 2),
                //  shape: RoundedRectangleBorder(
                //    borderRadius: BorderRadius.vertical(
                //      top: Radius.zero,
                //    ),
                //  ),
                //  child: ListTile(
                //    leading: Icon(Bootstrap.clock),
                //    title: Text("Exam timetable"),
                //    subtitle: Text("Psst.. Never miss an exam"),
                //  ),
                //),
                //Card(
                //  elevation: 0,
                //  color: Theme.of(context)
                //      .colorScheme
                //      .tertiaryContainer
                //      .withAlpha(100),
                //  margin: EdgeInsets.only(bottom: 2),
                //  shape: RoundedRectangleBorder(
                //    borderRadius: BorderRadius.vertical(
                //      top: Radius.zero,
                //    ),
                //  ),
                //  child: ListTile(
                //    leading: Icon(Bootstrap.filetype_pdf),
                //    title: Text("Past Revision Papers"),
                //    subtitle: Text("You want them? You get them.."),
                //  ),
                //),
                //
                //Card(
                //  elevation: 0,
                //  color: Theme.of(context)
                //      .colorScheme
                //      .tertiaryContainer
                //      .withAlpha(100),
                //  margin: EdgeInsets.only(bottom: 2),
                //  shape: RoundedRectangleBorder(
                //    borderRadius: BorderRadius.vertical(
                //      bottom: Radius.zero,
                //    ),
                //  ),
                //  child: ListTile(
                //    leading: Icon(Bootstrap.file_ppt),
                //    title: Text("Ask Me"),
                //    subtitle: Text("Boring notes? We'll help you revise"),
                //  ),
                //),
                //Card(
                //  elevation: 0,
                //  color: Theme.of(context)
                //      .colorScheme
                //      .tertiaryContainer
                //      .withAlpha(100),
                //  margin: EdgeInsets.only(bottom: 2),
                //  shape: RoundedRectangleBorder(
                //    borderRadius: BorderRadius.vertical(
                //      bottom: Radius.circular(12),
                //    ),
                //  ),
                //  child: ListTile(
                //    leading: Icon(Bootstrap.play),
                //    title: Text("Flash Cards"),
                //    subtitle: Text(
                //      "Curious if you really understood? Try our flashcards",
                //    ),
                //  ),
                //),
                //
                ////Page Break for student performance
                const SizedBox(height: 18),
                // Card(
                //   elevation: 0,
                //   color: Theme.of(context)
                //       .colorScheme
                //       .tertiaryContainer
                //       .withAlpha(100),
                //   margin: EdgeInsets.only(bottom: 2),
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.all(
                //       Radius.circular(12),
                //     ),
                //   ),
                //   child: ListTile(
                //     onTap: () async {
                //       context.pushNamed("gpa-calculator");
                //       if (await Vibration.hasVibrator()) {
                //         await Vibration.vibrate(
                //           duration: 32,
                //           sharpness: 250,
                //         );
                //       }
                //     },
                //     leading: Icon(Bootstrap.activity),
                //     title: Text("GPA Calculator"),
                //     subtitle: Text("Watch out for those grades!"),
                //   ),
                // ),
                //
                Card(
                  elevation: 0,
                  color: Theme.of(context)
                      .colorScheme
                      .tertiaryContainer
                      .withAlpha(100),
                  margin: EdgeInsets.only(bottom: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: ListTile(
                    onTap: () async {
                      context.pushNamed("refer-a-friend");
                      if (await Vibration.hasVibrator()) {
                        await Vibration.vibrate(
                          duration: 32,
                          sharpness: 250,
                        );
                      }
                    },
                    leading: Icon(Icons.person_add_outlined),
                    title: Text("Add a friend"),
                    subtitle: Text(
                      "Add a friend to Academia to earn vibe points",
                    ),
                  ),
                ),

                Card(
                  elevation: 0,
                  color: Theme.of(context)
                      .colorScheme
                      .tertiaryContainer
                      .withAlpha(100),
                  margin: EdgeInsets.only(bottom: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                  ),
                  child: ListTile(
                    onTap: () async {
                      context.pushNamed("exam-timetable");
                      if (await Vibration.hasVibrator()) {
                        await Vibration.vibrate(
                          duration: 32,
                          sharpness: 250,
                        );
                      }
                    },
                    leading: Icon(Clarity.bug_line),
                    title: Text("Exam TimeTable"),
                    subtitle: Text(
                      "Tick Tock The clock",
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
