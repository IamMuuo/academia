import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProfilePageMobile extends StatefulWidget {
  const ProfilePageMobile({super.key});

  @override
  State<ProfilePageMobile> createState() => _ProfilePageMobileState();
}

class _ProfilePageMobileState extends State<ProfilePageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            title: const Text("My Profile"),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Bootstrap.pen),
              ),
            ],
          ),
          SliverPinnedHeader(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(12),
              child: Column(
                spacing: 12,
                children: [
                  const CircleAvatar(
                    radius: 80,
                  ),
                  Text(
                    "John Doe Sang Kipkemboi",
                    style: Theme.of(context).textTheme.headlineSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    "Some long bio here to be here",
                    overflow: TextOverflow.visible,
                  ),
                  FilledButton(
                    onPressed: () {},
                    child: const Text("Preview my school ID"),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverClip(
              child: MultiSliver(
                children: const [
                  ListTile(
                    leading: Icon(Bootstrap.hash),
                    title: Text("Admission Number"),
                    subtitle: Text("21-1000"),
                  ),
                  ListTile(
                    leading: Icon(Bootstrap.compass),
                    title: Text("Campus"),
                    subtitle: Text("Athi River"),
                  ),
                  ListTile(
                    leading: Icon(Bootstrap.phone),
                    title: Text("Phone Number"),
                    subtitle: Text("078277272"),
                  ),
                  ListTile(
                    leading: Icon(Bootstrap.envelope_heart),
                    title: Text("Email"),
                    subtitle: Text("someone@example.com"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
