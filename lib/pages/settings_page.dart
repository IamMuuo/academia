import 'package:academia/exports/barrel.dart';
import 'package:academia/main.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final settingsController = Get.find<SettingsController>();
  final UserController userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            snap: true,
            pinned: true,
            floating: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              title: const Text("Settings"),
            ),
          ),
          SliverFillRemaining(
            child: SingleChildScrollView(
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Personal Preferences",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Ionicons.person_circle),
                      title: const Text("Show Profile Picture"),
                      trailing: Switch(
                        value: settingsController
                            .settings.value.showProfilePicture,
                        onChanged: (value) {
                          settingsController.settings.update(
                            (val) {
                              val?.showProfilePicture = value;
                            },
                          );
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Ionicons.image),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ImageConfigScreen(
                              title: "Profile Picture Configuration",
                              onImagePicked: (file) async {
                                final result =
                                    await userController.uploadProfilePicture(
                                  file!,
                                );

                                result.fold((l) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text("Error"),
                                      content: Text(l),
                                    ),
                                  );
                                }, (r) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => const AlertDialog(
                                      title: Text("Success"),
                                      content: Text(
                                          "Successfully updated profile picture"),
                                    ),
                                  );
                                });
                              },
                            ),
                          ),
                        );
                      },
                      title: const Text("Change your profile picture"),
                    ),
                    ListTile(
                      leading: const Icon(Ionicons.wallet),
                      title: const Text("Show Fee Statistics"),
                      trailing: Switch(
                        value:
                            settingsController.settings.value.showFeeStatistics,
                        onChanged: (value) {
                          settingsController.settings.update(
                            (val) {
                              val?.showFeeStatistics = value;
                            },
                          );
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Ionicons.balloon),
                      title: const Text("Wish me happy birthday"),
                      trailing: Switch(
                        value: settingsController.settings.value.showBirthDay,
                        onChanged: (value) {
                          settingsController.settings.update(
                            (val) {
                              val?.showBirthDay = value;
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Student Performance",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Ionicons.newspaper),
                      title: const Text("Enable transcript feature"),
                      trailing: Switch(
                        value: settingsController.settings.value.showTranscript,
                        onChanged: (value) {
                          settingsController.settings.update(
                            (val) {
                              val?.showTranscript = value;
                            },
                          );
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Ionicons.document),
                      title: const Text("Enable student audit feature"),
                      trailing: Switch(
                        value: settingsController.settings.value.showAudit,
                        onChanged: (value) {
                          settingsController.settings.update(
                            (val) {
                              val?.showAudit = value;
                            },
                          );
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Ionicons.sync),
                      title: const Text("Show exam timetable"),
                      subtitle: Text(
                        "Shows exam timetable instead of homescreen during exam period",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      trailing: Switch(
                        value:
                            settingsController.settings.value.showExamTimetable,
                        onChanged: (value) {
                          settingsController.settings.update(
                            (val) {
                              val?.showExamTimetable = value;
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Dangerous Actions",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.error),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Ionicons.trash),
                      title: const Text("Delete my account"),
                      onTap: () {},
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: FilledButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Confirmation"),
                              content: const Text(
                                "Are you sure you want to logout? Doing this will result to  data loss!",
                              ),
                              actions: [
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel"),
                                ),
                                FilledButton(
                                  onPressed: () async {
                                    await HapticFeedback.heavyImpact();
                                    await settingsController.logout();
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Academia(),
                                        ),
                                      );
                                    }

                                    // if (context.mounted)
                                    // exit(0);
                                  },
                                  child: const Text("Yes leave"),
                                )
                              ],
                            ),
                          );
                        },
                        child: const Text("Logout"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
