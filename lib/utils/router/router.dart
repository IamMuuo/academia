import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:academia/features/auth/auth.dart';

class AcademiaRouter {
  static GoRouter get router => _router;
  static GlobalKey<NavigatorState> get globalNavigatorKey =>
      GlobalKey<NavigatorState>();

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
        path: "/auth",
        name: "/auth",
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: "/register",
        name: "/register",
        builder: (context, state) => const SignUpPage(),
      ),
    ],
  );
}

class DefaultRoute extends StatelessWidget {
  const DefaultRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginPage();
  }
}
