import 'package:academia/controllers/profile_page_controller.dart';
import 'package:academia/widgets/info_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academia/widgets/gpa_info_widget.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfilePageController profilePageController =
        Get.put(ProfilePageController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.settings,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.blue[300],
              child: Image.asset(
                "assets/images/holding_back.png",
              ),
            ),
          ),
          // List items
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.grey[100],
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      '${profilePageController.user!.name}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  // Gpa badge + gpa + completed units
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          'assets/images/bored.png',
                          width: 100,
                          height: 100,
                        ),
                        const GPAINFO(),
                        const GPAINFO(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView(
                      children: const [
                        InfoCard(),
                        InfoCard(),
                        InfoCard(),
                        InfoCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
