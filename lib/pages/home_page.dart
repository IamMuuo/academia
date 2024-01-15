import 'package:academia/controllers/settings_controller.dart';
import 'package:academia/pages/courses_page.dart';
import 'package:academia/pages/dashboard.dart';
import 'package:academia/pages/profile_page.dart';
import 'package:academia/pages/tool_page.dart';
import 'package:flutter/material.dart';
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
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    Get.put(SettingsController());
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
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
