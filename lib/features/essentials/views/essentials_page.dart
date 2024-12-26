import 'package:academia/features/essentials/views/essentials_mobile_page.dart';
import 'package:academia/utils/responsive/responsive.dart';
import 'package:flutter/material.dart';

class EssentialsPage extends StatelessWidget {
  const EssentialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          constraints.maxWidth < ScreenDimension.mobileWidth
              ? const EssentialsMobilePage()
              : const Center(
                  child: Text("Essentials coming soon"),
                ),
    );
  }
}
