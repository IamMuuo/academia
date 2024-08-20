import 'package:academia/exports/barrel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: true,
          floating: true,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const OrganizationsPage(),
                ),
              );
            },
            icon: const Icon(Ionicons.planet_outline),
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
                const ProfilePictureWidget(
                  profileSize: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  "@${userController.user.value!.username}",
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
                            userController.user.value!.admissionNumber,
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
                            userController.user.value!.nationalId,
                            style: GoogleFonts.jetBrainsMono(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const MembershipPage(),
                      ),
                    );
                  },
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
                content:
                    "${userController.user.value!.firstName.title()} ${userController.user.value!.lastName.title()}",
                icon: Ionicons.person,
              ),
              InfoCard(
                title: "Gender",
                content: (userController.user.value!.gender).title(),
                icon: Ionicons.male_female,
              ),
              InfoCard(
                title: "Address",
                content: userController.user.value!.address,
                icon: Ionicons.compass,
              ),
              InfoCard(
                title: "Email",
                content: userController.user.value!.email,
                icon: Ionicons.mail,
              ),
              InfoCard(
                title: "Campus",
                content: userController.user.value!.campus.title(),
                icon: Ionicons.telescope,
              ),
              InfoCard(
                title: "Academic Status",
                content:
                    userController.user.value!.active ? "Active" : "Inactive",
                icon: Ionicons.calendar,
              ),
              Obx(
                () => InfoCard(
                  title: "Vibe Points",
                  content: userController.user.value!.vibePoints.toString(),
                  icon: Ionicons.wallet,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
