import 'package:flutter/material.dart';
import '../stories.dart';
import 'package:get/get.dart';

class OrganizationsPage extends StatefulWidget {
  const OrganizationsPage({super.key});

  @override
  State<OrganizationsPage> createState() => _OrganizationsPageState();
}

class _OrganizationsPageState extends State<OrganizationsPage> {
  final storyController = Get.find<StoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Obx(() => SliverAppBar(
                title: storyController.stories.isEmpty
                    ? Text("Empty")
                    : Text("Organizations"),
              )),
        ],
      ),
    );
  }
}
