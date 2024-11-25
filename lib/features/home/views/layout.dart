import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        selectedIndex: _selectedIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(OctIcons.graph),
            label: "Statistics",
          ),
          NavigationDestination(
            icon: Icon(OctIcons.repo),
            label: "Courses",
          ),
          NavigationDestination(
            icon: Icon(OctIcons.rocket),
            label: "Essentials",
          ),
          NavigationDestination(
            icon: Icon(OctIcons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
