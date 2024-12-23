import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CoursesPageMobile extends StatefulWidget {
  const CoursesPageMobile({super.key});

  @override
  State<CoursesPageMobile> createState() => _CoursesPageMobileState();
}

class _CoursesPageMobileState extends State<CoursesPageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {},
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Courses",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontFamily: GoogleFonts.libreBaskerville().fontFamily,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
