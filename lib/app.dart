import 'package:academia/utils/router/router.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:google_fonts/google_fonts.dart';

class Academia extends StatelessWidget {
  final String flavor;
  const Academia({
    super.key,
    required this.flavor,
  });

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightscheme, darkscheme) => MaterialApp.router(
        title: flavor,
        routerConfig: AcademiaRouter.router,
        theme: ThemeData(
          colorScheme: lightscheme,
          useMaterial3: true,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
      ),
    );
  }
}
