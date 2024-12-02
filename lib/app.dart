import 'package:academia/utils/router/router.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:google_fonts/google_fonts.dart';

class Academia extends StatelessWidget {
  const Academia({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightscheme, darkscheme) => MaterialApp.router(
        title: "Academia",
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
