import 'package:academia/utils/router/router.dart';
import 'package:flutter/material.dart';

class Academia extends StatelessWidget {
  const Academia({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Academia",
      routerConfig: AcademiaRouter.router,
      theme: ThemeData(
        colorSchemeSeed: Colors.amber,
      ),
    );
  }
}
