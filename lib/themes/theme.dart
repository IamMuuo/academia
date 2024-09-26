import 'package:academia/exports/barrel.dart';
export 'package:academia/themes/colors.dart';

ThemeData lightModeTheme = ThemeData(
  useMaterial3: true,
  fontFamily: "helvetica",
  colorScheme: lightColorScheme,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    showSelectedLabels: true,
    showUnselectedLabels: true,
  ),
);

ThemeData darkModeTheme = ThemeData(
  useMaterial3: true,
  fontFamily: "helvetica",
  colorScheme: darkColorScheme,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    showSelectedLabels: true,
    showUnselectedLabels: true,
    elevation: 0,
    selectedItemColor: lightColorScheme.tertiary,
  ),
);
