import 'dart:async';

import 'package:academia/features/essentials/essentials.dart';
import 'package:academia/features/features.dart';
import 'package:academia/utils/responsive/responsive.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;
  // final pages = const [
  //   Center(
  //     child: Text("Statistics"),
  //   ),
  //   Center(
  //     child: Text("Courses"),
  //   ),
  //   Center(
  //     child: Text("Social"),
  //   ),
  //   Center(
  //     child: Text("Statistics"),
  //   ),
  //   ProfilePage()
  // ];

  // Stream subscription for network notification
  @override
  void initState() {
    super.initState();
    StreamSubscription<List<ConnectivityResult>> subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      // Received changes in available connectivity types!
      if (result.contains(ConnectivityResult.none)) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            duration: Duration(days: 30),
            showCloseIcon: true,
            content: Text(
                "Your internet connection has been lost some features may not work"),
          ),
        );
        return;
      }
      if (!result.contains(ConnectivityResult.none)) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            showCloseIcon: true,
            content: Text("Your internet connection has been restored"),
          ),
        );
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: constraints.maxWidth < ScreenDimension.mobileWidth
            ? IndexedStack(
                index: _selectedIndex,
                children: const [
                  Center(
                    child: Text("Statistics"),
                  ),
                  CoursesPage(),
                  Center(
                    child: Text("Social"),
                  ),
                  EssentialsPage(),
                  ProfilePage()
                ],
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
                      children: const [
                        Center(
                          child: Text("Statistics"),
                        ),
                        CoursesPage(),
                        Center(
                          child: Text("Social"),
                        ),
                        EssentialsPage(),
                        ProfilePage()
                      ],
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
