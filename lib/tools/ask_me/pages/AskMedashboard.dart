import 'package:academia/themes/colors.dart';
import 'package:flutter/material.dart';

class AskMeDashboard extends StatefulWidget {
  const AskMeDashboard({super.key});

  @override
  State<AskMeDashboard> createState() => _AskMeDashboardState();
}

class _AskMeDashboardState extends State<AskMeDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),          
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Ask Me".toUpperCase(),
                      style: const  TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ],
                ),              
          ),
          const SizedBox(height: 20,),
          Center(
            child: Image.asset(
              'assets/images/askMe_Home.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              color: lightColorScheme.tertiary,
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: 8,
                itemBuilder: (context, index) {
                  return _buildQuizCard();
                },
              ),
            ),             
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: lightColorScheme.tertiary,
        foregroundColor: Colors.white,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildQuizCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: lightColorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Title'),
            Text('20%'),
          ],
        ),
      ),
    );
  }
}