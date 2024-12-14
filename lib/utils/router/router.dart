import 'package:academia/features/auth/cubit/auth_cubit.dart';
import 'package:academia/features/auth/cubit/auth_states.dart';
import 'package:academia/utils/router/default_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  static const String userSelection = "user-selection";
  static const String onboarding = "onboarding";

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
        path: "/$onboarding",
        name: onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: "/$auth",
        name: auth,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: "/$home",
        name: home,
        builder: (context, state) => const Layout(),
      ),
      GoRoute(
        name: profile,
        path: "/$profile",
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        name: userSelection,
        path: "/$userSelection",
        builder: (context, state) => const UserSelectionPage(),
      ),
    ],
  );
}
