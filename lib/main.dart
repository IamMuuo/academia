import 'package:academia/pages/intro_page.dart';
import 'package:academia/themes/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academia',
      home: const IntroPage(),
      theme: lightModeTheme,
    );
  }
}
