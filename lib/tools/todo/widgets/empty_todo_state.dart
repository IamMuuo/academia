import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import '../todo_view_page.dart';
import 'package:lottie/lottie.dart';

class EmptyTodoHomeScreen extends StatelessWidget {
  const EmptyTodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(
          "assets/lotties/study.json",
        ),
        Text(
          "Nothing here yet? Create a new task to get started with productivity",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const TodoViewPage(),
            ));
          },
          icon: const Icon(Ionicons.add),
          label: const Text("Create todo item"),
        ),
      ],
    );
  }
}
