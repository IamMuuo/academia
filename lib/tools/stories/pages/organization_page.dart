import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../stories.dart';

class OrganizationPage extends StatelessWidget {
  const OrganizationPage({
    super.key,
    required this.organization,
    required this.stories,
  });
  final Organization organization;
  final List<Story> stories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(organization.name),
            pinned: true,
            floating: true,
            snap: true,
          ),
          SliverToBoxAdapter(
            child: OrganizationProfilePicture(
              organization: organization,
              stories: stories,
              radius: 80,
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(18),
              child: Text(
                "@${organization.name}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Ionicons.phone_portrait),
                  title: const Text("Phone"),
                  subtitle: Text(
                    organization.phone,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                ListTile(
                  leading: const Icon(Ionicons.mail),
                  title: const Text("Email"),
                  subtitle: Text(
                    organization.email,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Text(
                "About ${organization.name}",
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverFillRemaining(
              child: Text(organization.description),
            ),
          ),
        ],
      ),
    );
  }
}
