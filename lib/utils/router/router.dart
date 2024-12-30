import 'package:academia/database/database.dart';
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
  static const String userSelection = "user-selection";
  static const String onboarding = "onboarding";
  static const String courseView = "course-view";
  static const String todo = "todo";
  static const String todoView = "todo-view";

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
      GoRoute(
        name: todo,
        path: "/$todo",
        builder: (context, state) => const TodoPage(),
      ),
      GoRoute(
        name: todoView,
        path: "/$todoView",
        builder: (context, state) {
          TodoData? todo = state.extra as TodoData?;
          return TodoViewPage(todoData: todo);
        },
      ),
      GoRoute(
        name: courseView,
        path: "/$courseView",
        builder: (context, state) {
          final CourseData course = state.extra as CourseData;
          return CourseMobileViewPage(course: course);
        },
      ),
    ],
  );
}
