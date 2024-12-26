import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sliver_tools/sliver_tools.dart';

class EssentialsMobilePage extends StatefulWidget {
  const EssentialsMobilePage({super.key});

  @override
  State<EssentialsMobilePage> createState() => _EssentialsMobilePageState();
}

class _EssentialsMobilePageState extends State<EssentialsMobilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            backgroundColor: Theme.of(context).colorScheme.errorContainer,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "Essentials",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontFamily: GoogleFonts.libreBaskerville().fontFamily,
                    ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: MultiSliver(
              children: const [
                Card(
                  elevation: 0,
                  margin: EdgeInsets.only(bottom: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Bootstrap.bell),
                    title: Text("Todos & Assigments"),
                    subtitle: Text("Keep track of your assignments and todos"),
                  ),
                ),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.only(bottom: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.zero,
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Bootstrap.clock),
                    title: Text("Exam timetable"),
                    subtitle: Text("Psst.. Never miss an exam"),
                  ),
                ),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.only(bottom: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.zero,
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Bootstrap.filetype_pdf),
                    title: Text("Past Revision Papers"),
                    subtitle: Text("You want them? You get them.."),
                  ),
                ),

                Card(
                  elevation: 0,
                  margin: EdgeInsets.only(bottom: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.zero,
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Bootstrap.file_ppt),
                    title: Text("Ask Me"),
                    subtitle: Text("Boring notes? We'll help you revise"),
                  ),
                ),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.only(bottom: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Bootstrap.play),
                    title: Text("Flash Cards"),
                    subtitle: Text(
                      "Curious if you really understood? Try our flashcards",
                    ),
                  ),
                ),

                //Page Break for student performance
                SizedBox(height: 18),
                Card(
                  margin: EdgeInsets.only(bottom: 2),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Bootstrap.bell),
                    title: Text("Student Audit"),
                    subtitle: Text("Keep track of your assignments and todos"),
                  ),
                ),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.only(bottom: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.zero,
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Bootstrap.activity),
                    title: Text("GPA Calculator"),
                    subtitle: Text("Watch out for those grades!"),
                  ),
                ),

                Card(
                  elevation: 0,
                  margin: EdgeInsets.only(bottom: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(12),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Bootstrap.play),
                    title: Text("Flash Cards"),
                    subtitle: Text(
                      "Curious if you really understood? Try our flashcards",
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
