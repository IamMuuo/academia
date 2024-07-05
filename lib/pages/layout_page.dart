import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    Get.put(StoryController());

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentIndex,
          children: const [
            DashBoard(),
            ToolsPage(),
            CoursesPage(),
            ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Ionicons.home),
            icon: Icon(Ionicons.home_outline),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.hammer_outline),
            activeIcon: Icon(Ionicons.hammer),
            label: 'Tools',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.golf_outline),
            activeIcon: Icon(Ionicons.golf),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Ionicons.person_outline),
            activeIcon: Icon(Ionicons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
