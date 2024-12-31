import 'package:academia/features/courses/views/courses_page_desktop.dart';
import 'package:academia/features/courses/views/courses_page_mobile.dart';
import 'package:academia/utils/utils.dart';
import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          constraints.maxWidth < ScreenDimension.mobileWidth
              ? const CoursesPageMobile()
              : const CoursesPageDesktop(),
    );
  }
}
