import 'package:flutter/material.dart';
import 'home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
              "The app you've all been waiting for",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // subtitle
            const Padding(
              padding: EdgeInsets.all(16),
              child:  Text(
                'Academia is for you by you',
                textAlign: TextAlign.center,
              ),
            ),


            GestureDetector(
              onTap:()=> Navigator.pushReplacement(context, MaterialPageRoute
              (builder: (context){
                  return const HomePage();
                })),

              child: Container( 
              decoration: BoxDecoration( 
                color: Colors.brown[900],
                borderRadius: BorderRadius.circular(12),

              ),
              width: 120,
              padding: const EdgeInsets.all(22),
              child: const Text(
                'Get Started',
                style: TextStyle(
                    color:Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
              ),
            ),
            ),
          ],

        ),
      ),
    );
  }
}
