import 'package:academia/exports/barrel.dart';
import 'package:google_fonts/google_fonts.dart';
export 'package:academia/themes/colors.dart';

ThemeData lightModeTheme = ThemeData(
  fontFamily: GoogleFonts.inter().fontFamily,
  colorScheme: lightColorScheme,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: true,
    showUnselectedLabels: true,
    elevation: 0,
    selectedItemColor: lightColorScheme.tertiary,
  ),
);

ThemeData darkModeTheme = ThemeData(
  fontFamily: GoogleFonts.inter().fontFamily,
  colorScheme: darkColorScheme,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: true,
    showUnselectedLabels: true,
    elevation: 0,
    selectedItemColor: lightColorScheme.tertiary,
  ),
);
