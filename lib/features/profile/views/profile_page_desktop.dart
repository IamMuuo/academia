import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePageDesktop extends StatefulWidget {
  const ProfilePageDesktop({super.key});

  @override
  State<ProfilePageDesktop> createState() => _ProfilePageDesktopState();
}

class _ProfilePageDesktopState extends State<ProfilePageDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Academia"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Bootstrap.arrow_clockwise),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          MultiSliver(
            children: const [
              Wrap(
                children: [
                  SizedBox(
                    width: 500,
                    child: ProfileCard(),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 12,
              children: [
                const CircleAvatar(
                  radius: 60,
                ),
                Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "John Doe",
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontFamily:
                                    GoogleFonts.libreBaskerville().fontFamily,
                              ),
                    ),
                    Text(
                      "Student",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    const Text(
                      "Athi River Campus",
                    ),
                  ],
                ),
                FilledButton.icon(
                  label: const Text("Edit Profile"),
                  onPressed: () {},
                  icon: const Icon(Bootstrap.pen),
                )
              ],
            ),
            const Divider(),
            ListTile(
              title: const Text("Email"),
              trailing: const Text("someone@example.com"),
              leadingAndTrailingTextStyle:
                  Theme.of(context).textTheme.bodyMedium,
              leading: const Icon(Bootstrap.envelope_at),
            ),
            ListTile(
              title: const Text("Phone"),
              trailing: const Text("0717171771"),
              leadingAndTrailingTextStyle:
                  Theme.of(context).textTheme.bodyMedium,
              leading: const Icon(Bootstrap.phone),
            ),
            ListTile(
              title: const Text("School"),
              trailing: const Text("School of Science Health and Engineering"),
              leadingAndTrailingTextStyle:
                  Theme.of(context).textTheme.bodyMedium,
              leading: const Icon(Bootstrap.git),
            )
          ],
        ),
      ),
    );
  }
}
