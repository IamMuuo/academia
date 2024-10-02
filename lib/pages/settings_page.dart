import 'package:academia/exports/barrel.dart';
import 'package:academia/main.dart';
import 'package:academia/notifier/local_notification_channel.dart';
import 'package:academia/notifier/local_notifier_service.dart';
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
                      leading: const Icon(Ionicons.lock_closed),
                      title: const Text("Require authentication for academia"),
                      subtitle: const Text(
                        "Will require you authenticate the app each time you launch academia",
                      ),
                      trailing: Switch(
                        value:
                            settingsController.settings.value.requireAppUnlock,
                        onChanged: (value) {
                          settingsController.settings.value = settingsController
                              .settings.value
                              .copyWith(requireAppUnlock: value);
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Ionicons.person_circle),
                      title: const Text("Show Profile Picture"),
                      trailing: Switch(
                        value: settingsController
                            .settings.value.showProfilePicture,
                        onChanged: (value) {
                          settingsController.settings.value = settingsController
                              .settings.value
                              .copyWith(showProfilePicture: value);
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
                          settingsController.settings.value = settingsController
                              .settings.value
                              .copyWith(showFeeStatistics: value);
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Ionicons.balloon),
                      title: const Text("Wish me happy birthday"),
                      trailing: Switch(
                        value: settingsController.settings.value.showBirthDay,
                        onChanged: (value) {
                          settingsController.settings.value = settingsController
                              .settings.value
                              .copyWith(showBirthDay: value);
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
                          settingsController.settings.value = settingsController
                              .settings.value
                              .copyWith(showTranscript: value);
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Ionicons.document),
                      title: const Text("Enable student audit feature"),
                      trailing: Switch(
                        value: settingsController.settings.value.showAudit,
                        onChanged: (value) {
                          settingsController.settings
                              .update((val) => val?.copyWith(showAudit: value));
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
                              (val) => val?.copyWith(showExamTimetable: value));
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
                      leading: const Icon(Ionicons.alarm_outline),
                      title: const Text("Cancel All notifications"),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Confirmation"),
                            content: const Text(
                              "Cancel all notifications? You won't get any reminders and updates for your existing tasks and assignments",
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
                                  await LocalNotifierService()
                                      .cancelAllNotifications();
                                  await LocalNotifierService().showNotification(
                                    id: 0,
                                    title: "Notifications",
                                    color: Colors.red,
                                    body:
                                        "You have successfully cleared all pending notifications",
                                    channelKey: LocalNotificationChannelType
                                        .general.channelKey,
                                  );
                                },
                                child: const Text("Yes cancel them"),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Ionicons.trash),
                      title: const Text("Delete my account"),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Confirmation"),
                            content: const Text(
                              "Are you sure you want to delete this acount? Doing this will result to  data loss and cannot be restored!",
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
                                  await userController.deleteUser();
                                  await LocalNotifierService().showNotification(
                                    id: 0,
                                    title: "Damn",
                                    notificationType: NotificationType.bigText,
                                    body:
                                        "Goodbye, your entire user information has been deleted from our platform, it was a pleasure being a part of your academic journey",
                                    channelKey: LocalNotificationChannelType
                                        .general.channelKey,
                                  );

                                  if (context.mounted) {
                                    Navigator.pop(context);
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (context) => const Academia(),
                                      ),
                                    );
                                  }
                                },
                                child: const Text("Yes delete it"),
                              )
                            ],
                          ),
                        );
                      },
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
                                    await LocalNotifierService()
                                        .showNotification(
                                      id: 0,
                                      title: "Goodbye",
                                      body:
                                          "Bye ${userController.user.value!.firstName.title()}, why did you leave? we hope to see you again",
                                      channelKey: LocalNotificationChannelType
                                          .general.channelKey,
                                    );
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const Academia(),
                                        ),
                                      );
                                    }
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
