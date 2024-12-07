import 'package:academia/features/profile/profile_page_desktop.dart';
import 'package:academia/features/profile/profile_page_mobile.dart';
import 'package:academia/utils/responsive/responsive.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) =>
          constraints.maxWidth < ScreenDimension.mobileWidth
              ? const ProfilePageMobile()
              : const ProfilePageDesktop(),
    );
  }
}
