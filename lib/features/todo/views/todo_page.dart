import 'package:academia/utils/router/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: true,
            floating: true,
            expandedHeight: 128,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Todos & Assignments"),
            ),
          ),
          SliverFillRemaining(
            child: Center(
              child: Text("You have no todos added yet"),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.pushNamed(AcademiaRouter.todoView);
        },
        child: const Icon(Bootstrap.plus_circle_dotted),
      ),
    );
  }
}
