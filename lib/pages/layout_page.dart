import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    Get.put(StoryController());

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: const [
            DashBoard(),
            CoursesPage(),
            ChirpHomePage(),
            ToolsPage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        elevation: 2,
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => setState(() => currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Ionicons.pulse_outline),
            label: 'Stats',
          ),
          NavigationDestination(
            icon: Icon(Ionicons.golf_outline),
            label: 'Courses',
          ),
          NavigationDestination(
            icon: Icon(Ionicons.logo_wechat),
            label: 'Chirp',
          ),
          NavigationDestination(
            icon: Icon(Ionicons.hammer_outline),
            label: 'Tools',
          ),
          NavigationDestination(
            icon: Icon(Ionicons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
