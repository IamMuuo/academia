import 'package:flutter/material.dart';

class ProfilePageMobile extends StatefulWidget {
  const ProfilePageMobile({super.key});

  @override
  State<ProfilePageMobile> createState() => _ProfilePageMobileState();
}

class _ProfilePageMobileState extends State<ProfilePageMobile> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Profile page mobile"),
      ),
    );
  }
}
