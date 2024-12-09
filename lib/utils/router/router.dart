import 'package:academia/utils/router/default_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/features/features.dart';

class AcademiaRouter {
  static GoRouter get router => _router;
  static GlobalKey<NavigatorState> get globalNavigatorKey =>
      GlobalKey<NavigatorState>();

  static const String register = "register";
  static const String auth = "auth";
  static const String profile = "profile";
  static const String home = "home";

  static final GoRouter _router = GoRouter(
    initialLocation: "/",
    navigatorKey: globalNavigatorKey,
    routes: [
      GoRoute(
        path: "/",
        name: "/",
        builder: (context, state) => const DefaultRoute(),
      ),
      GoRoute(
        path: "/$auth",
        name: auth,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: "/$register",
        name: register,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: "/$home",
        name: home,
        builder: (context, state) => const Layout(),
      ),
      GoRoute(
        path: profile,
        name: "/$profile",
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );
}
