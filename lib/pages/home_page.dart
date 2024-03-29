import 'package:academia/exports/barrel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  final pages = const [
    DashBoard(),
    ToolsPage(),
    CoursesPage(),
    SettingsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
    Get.put(TaskManagerController());
    Get.put(CoursesPageController());
    Get.put(NotificationsController());
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: IndexedStack(index: currentIndex, children: pages),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        enableFeedback: true,
        currentIndex: currentIndex,
        selectedItemColor: Theme.of(context).primaryColorDark,
        unselectedItemColor: Theme.of(context).primaryColorLight,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(CupertinoIcons.house_fill),
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.hammer),
            activeIcon: Icon(CupertinoIcons.hammer_fill),
            label: 'Tools',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.file_copy_outlined),
            activeIcon: Icon(Icons.file_copy),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
