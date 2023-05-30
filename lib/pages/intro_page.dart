import 'package:academia/pages/login_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Welcome image ...
            Padding(
              padding: const EdgeInsets.all(20),
              child: Image.asset('assets/images/girl_sitted.png'),
            ),

            // Welcoming message
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Your school life assistant awaits",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.black87,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // subtitle
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Academia is for you by you',
                textAlign: TextAlign.center,
              ),
            ),

            ElevatedButton(
              onPressed: () => Get.off(const LoginPage()),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                minimumSize: const Size(327, 60),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
              ),
              child: const Text(
                'Get Started',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
