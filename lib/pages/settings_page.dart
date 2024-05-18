import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Personal",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  "Change your personal settings",
                ),
                SettingsCard(
                  items: [
                    ListTile(
                      title: const Text("Show my profile picture"),
                      trailing: Switch(value: false, onChanged: (value) {}),
                    ),
                    ListTile(
                      title: const Text("Wish me happy bithday"),
                      trailing: Switch(value: false, onChanged: (value) {}),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Text(
                  "Academic Data",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  "Set some rules on your academic data",
                ),
                SettingsCard(
                  items: [
                    ListTile(
                      title: const Text("Lock my student audit"),
                      trailing: Switch(value: false, onChanged: (value) {}),
                    ),
                    ListTile(
                      title: const Text("Lock my transcript"),
                      trailing: Switch(value: false, onChanged: (value) {}),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Text(
                  "Finances",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  "Change your experiences on financal data",
                ),
                SettingsCard(
                  items: [
                    ListTile(
                      title: const Text("Lock my financial data"),
                      trailing: Switch(value: false, onChanged: (value) {}),
                    ),
                    ListTile(
                      title:
                          const Text("Notify me monthly on financial balances"),
                      trailing: Switch(value: false, onChanged: (value) {}),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Text(
                  "Reminders",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  "Set your reminders so that you dont miss events",
                ),
                SettingsCard(
                  items: [
                    ListTile(
                      title: const Text("Remind me of classes"),
                      trailing: Switch(value: false, onChanged: (value) {}),
                    ),
                    ListTile(
                      title: const Text("Remind me on todos"),
                      trailing: Switch(value: false, onChanged: (value) {}),
                    ),
                    ListTile(
                      title: const Text("Notify me on school events"),
                      trailing: Switch(value: false, onChanged: (value) {}),
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                Text(
                  "Updates",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.left,
                ),
                const Text(
                  "Be the first to recieve news about our new features",
                ),
                SettingsCard(
                  items: [
                    ListTile(
                      title: const Text("Push Notifications"),
                      trailing: Switch(value: false, onChanged: (value) {}),
                    ),
                    ListTile(
                      title: const Text("Show me on homescreen"),
                      trailing: Switch(value: false, onChanged: (value) {}),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
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
