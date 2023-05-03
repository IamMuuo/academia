import 'package:academia/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:academia/widgets/emojicon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController? _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[700],
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hi, Jessica!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            // Date
                            Text(
                              '5 May, 2023',
                              style: TextStyle(
                                color: Colors.grey[300],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue[400],
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),

                // Search bar
                Container(
                  padding: const EdgeInsets.only(
                    right: 16,
                    left: 16,
                  ),
                  child: TextField(
                    controller: _searchController,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blue[400],
                      suffixIcon: IconButton(
                        padding: const EdgeInsets.all(16),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      hintText: 'Looking for something?',
                      hintStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),

                // mood text
                const Text(
                  "What are you currently feeling?",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Emojicon(),
                    Emojicon(),
                    Emojicon(),
                    Emojicon(),
                  ],
                ),

                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),

                // Courses you are taking

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Heading section
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        child: Text(
                          'Your Courses',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Courses

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          CourseCard(),
                          SizedBox(height: 12),
                          CourseCard(),
                          SizedBox(height: 12),
                          CourseCard(),
                          SizedBox(height: 12),
                          CourseCard(),
                          SizedBox(height: 12),
                          CourseCard(),
                          SizedBox(height: 12),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
            elevation: 50,
            backgroundColor: Colors.blue,
            unselectedItemColor: Colors.blue[300],
            selectedItemColor: Colors.blue[800],
            useLegacyColorScheme: true,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
              ),
            ]));
  }
}
