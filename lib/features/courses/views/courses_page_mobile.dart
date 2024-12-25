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
              pinned: true,
              floating: true,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Courses",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontFamily: GoogleFonts.libreBaskerville().fontFamily,
                      ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverList.separated(
                itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(),
                    title: Text("ACS 200"),
                    subtitle: Text("PLAB * 10:00 - 13:00 * Fredrick Ogore")),
                separatorBuilder: (context, index) => SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
