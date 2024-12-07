import 'package:academia/features/features.dart';
import 'package:academia/features/profile/profile_page_desktop.dart';
import 'package:academia/utils/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;
  final pages = const [
    Center(
      child: Text("Statistics"),
    ),
    Center(
      child: Text("Statistics"),
    ),
    Center(
      child: Text("Statistics"),
    ),
    Center(
      child: Text("Statistics"),
    ),
    ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: constraints.maxWidth < ScreenDimension.mobileWidth
            ? IndexedStack(
                index: _selectedIndex,
                children: pages,
              )
            : Row(
                children: [
                  NavigationRail(
                    leading: Image.asset(
                      "assets/icons/academia.png",
                      width: 45,
                    ),
                    labelType: NavigationRailLabelType.all,
                    onDestinationSelected: (index) => setState(() {
                      _selectedIndex = index;
                    }),
                    elevation: 2,
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(OctIcons.mark_github),
                    ),
                    destinations: const [
                      NavigationRailDestination(
                        icon: Icon(OctIcons.mortar_board),
                        label: Text("Statistics"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(OctIcons.repo),
                        label: Text("Courses"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(OctIcons.comment_discussion),
                        label: Text("Social"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(OctIcons.rocket),
                        label: Text("Essentials"),
                      ),
                      NavigationRailDestination(
                        icon: Icon(OctIcons.person),
                        label: Text("Profile"),
                      ),
                    ],
                    selectedIndex: _selectedIndex,
                  ),
                  Expanded(
                    child: IndexedStack(
                      index: _selectedIndex,
                      children: pages,
                    ),
                  )
                ],
              ),
        bottomNavigationBar: constraints.maxWidth > ScreenDimension.mobileWidth
            ? null
            : NavigationBar(
                onDestinationSelected: (index) => setState(() {
                  _selectedIndex = index;
                }),
                selectedIndex: _selectedIndex,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(OctIcons.mortar_board),
                    selectedIcon: Icon(OctIcons.mortar_board),
                    label: "Statistics",
                  ),
                  NavigationDestination(
                    icon: Icon(OctIcons.repo),
                    label: "Courses",
                  ),
                  NavigationDestination(
                    icon: Icon(OctIcons.comment_discussion),
                    label: "Social",
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
      ),
    );
  }
}
