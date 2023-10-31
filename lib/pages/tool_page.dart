import 'package:academia/controllers/tool_page_controller.dart';
import 'package:academia/pages/gpacalculator_page.dart';
import 'package:academia/pages/webview_page.dart';
import 'package:academia/widgets/tool_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ToolPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tools"),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          ToolCard(
            ontap: () {
              Get.to(
                const WebviewPage(
                  title: "Daystar Elearning",
                  url: "https://elearning.daystar.ac.ke",
                ),
              );
            },
            icon: const Icon(
              CupertinoIcons.book_circle,
              color: Colors.white,
            ),
            title: "To Elearning",
            backGround: Colors.blueGrey,
          ),
          ToolCard(
            ontap: () async {
              await controller.fetchToken();
            },
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            title: "Generate Token",
            backGround: Colors.blueGrey,
          ),
          ToolCard(
            ontap: () {},
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            title: "My Attendance",
            backGround: Colors.blueGrey,
          ),
          ToolCard(
            ontap: () {
              Get.to(() => GpaCalculator());
            },
            icon: const Icon(
              Icons.calculate,
              color: Colors.white,
            ),
            title: "GPA Calculator",
            backGround: Colors.blueGrey,
          ),
          ToolCard(
            ontap: () {},
            icon: const Icon(
              Icons.school,
              color: Colors.white,
            ),
            title: "My Scedules",
            backGround: Colors.blueGrey,
          ),
          ToolCard(
            ontap: () {},
            icon: const Icon(
              Icons.abc_rounded,
              color: Colors.white,
            ),
            title: "My Grades",
            backGround: Colors.blueGrey,
          ),
        ],
      ),
    );
  }
}
