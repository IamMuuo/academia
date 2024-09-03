import 'package:flutter/material.dart';

class EmptyTodoHomeScreen extends StatelessWidget {
  const EmptyTodoHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          snap: true,
          floating: true,
          pinned: true,
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Todos"),
          ),
        ),
        SliverFillRemaining(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/man-and-woman-searching.png",
              ),
              Text(
                "You have no todo items yet, create one to get started",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
