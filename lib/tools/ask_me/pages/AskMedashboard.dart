import 'package:academia/themes/colors.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class AskMeDashboard extends StatefulWidget {
  const AskMeDashboard({super.key});

  @override
  State<AskMeDashboard> createState() => _AskMeDashboardState();
}

class _AskMeDashboardState extends State<AskMeDashboard> {
  TextEditingController titleController = TextEditingController();

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
        onPressed: () {
          showModalBottomSheet(
            backgroundColor: lightColorScheme.onPrimary,
            context: context, 
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            isScrollControlled: true,
            showDragHandle: true,
            builder: (context) => FractionallySizedBox(
              heightFactor: 0.7,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titleController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value?.length == null) {
                          return "Please enter a title";
                        }
                        return null;
                      },
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: "Please Enter Title for your Document",
                        label: const Text("Title"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    const Text(
                      'Question type',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                      ChoiceWidget(label: 'Multiple choice'),
                      const SizedBox(width: 10),
                      ChoiceWidget(label: 'True/False'),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Set a timer",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            TimeInputField(label: "Minute", initialValue: "2"),
                            Text(" : ", style: TextStyle(fontSize: 20)),
                            TimeInputField(label: "Seconds", initialValue: "30"),
                          ]
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0,),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          //padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
                          backgroundColor: Colors.lightBlue[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        onPressed: () {}, 
                        child: const Text("Generate"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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