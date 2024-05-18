import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    final settingsController = Get.find<SettingsController>();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: true,
          floating: true,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Ionicons.terminal_outline),
          ),
          title: const Text("Your profile"),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsPage()));
              },
              icon: const Icon(Ionicons.menu_outline),
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 22),
            // height:,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(800),
                    ),
                    child: (settingsController
                                .settings.value!.showProfilePicture ??
                            false)
                        ? Image.memory(
                            Uint8List.fromList(
                              base64Decode(userController.user.value!.profile!
                                  .replaceFirst("data:image/gif;base64,", "")),
                            ),
                            fit: BoxFit.contain,
                          )
                        : Image.asset(
                            userController.user.value!.gender == "male"
                                ? "assets/images/male_student.png"
                                : "assets/images/female_student.png",
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "@${userController.user.value!.name!.split(' ')[0]}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      child: Column(
                        children: [
                          const Icon(Ionicons.id_card_outline),
                          const SizedBox(height: 4),
                          Text(
                            userController.user.value!.regno!,
                            style: GoogleFonts.jetBrainsMono(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      child: Column(
                        children: [
                          const Icon(Ionicons.person_outline),
                          const SizedBox(height: 4),
                          Text(
                            userController.user.value!.idno!,
                            style: GoogleFonts.jetBrainsMono(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: const Text("Preview school ID"),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: true,
          child: ListView(
            children: [
              InfoCard(
                title: "Official Name",
                content: userController.user.value!.name!.title(),
                icon: Ionicons.person,
              ),
              InfoCard(
                title: "Gender",
                content:
                    (userController.user.value!.gender ?? "unkown").title(),
                icon: Ionicons.male_female,
              ),
              InfoCard(
                title: "Address",
                content: userController.user.value!.address ?? "unkown",
                icon: Ionicons.compass,
              ),
              InfoCard(
                title: "Email",
                content: userController.user.value!.email ?? "unkown",
                icon: Ionicons.mail,
              ),
              InfoCard(
                title: "Campus",
                content: userController.user.value!.campus ?? "unkown",
                icon: Ionicons.telescope,
              ),
              InfoCard(
                title: "Academic Status",
                content: userController.user.value!.dateOfBirth ?? "unkown",
                icon: Ionicons.calendar,
              ),
            ],
          ),
        )
      ],
    );
  }
}
