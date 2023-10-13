import 'package:academia/widgets/tool_card.dart';
import 'package:flutter/material.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tools"),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          ToolCard(
            icon: const Icon(
              Icons.food_bank,
              color: Colors.white,
            ),
            ontap: () {},
            title: "Generate Token",
            backGround: Colors.blueGrey,
          ),
          ToolCard(
            ontap: () {},
            icon: const Icon(
              Icons.calculate,
              color: Colors.white,
            ),
            title: "GPA Calculator",
            backGround: Colors.blueGrey,
          )
        ],
      ),
    );
  }
}
