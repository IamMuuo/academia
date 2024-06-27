import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            expandedHeight: 160,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text(
                "Settings",
                style: TextStyle(color: Colors.black),
              ),
            ),
            pinned: true,
            floating: true,
          ),
          SliverSafeArea(
            minimum: const EdgeInsets.all(12),
            sliver: SliverFillRemaining(
              child: ListView(
                children: [
                  Text(
                    "Personal Settings",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Show profile picture"),
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  const SizedBox(height: 2),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Show fees statistics"),
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    "Student Performance",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Divider(),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Hide student audit"),
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text("Hide student transcript"),
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  const SizedBox(height: 2),
                  FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Ionicons.log_out),
                    label: const Text("Logout"),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SettingsCard extends StatelessWidget {
  const SettingsCard({super.key, required this.items});
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface.withAlpha(200),
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: Theme.of(context).colorScheme.shadow, width: 2),
      ),
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        children: items,
      ),
    );
  }
}
