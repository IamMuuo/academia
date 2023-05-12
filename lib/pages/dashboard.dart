import 'package:academia/widgets/course_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:academia/widgets/emojicon.dart';
import 'package:intl/intl.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    // _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                        'Hi, Judas!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Date
                      Text(
                        DateFormat.yMMMMEEEEd().format(DateTime.now()),
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
                        CupertinoIcons.bell_fill,
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
                    CupertinoIcons.search,
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
            "How are you currently feeling?",
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
            children: buildEmojiCons(),
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),

          // Courses you are taking

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(25),
              color: Colors.grey[100],
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Your courses',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    // list view of courses
                    Expanded(
                      child: ListView(
                        children: buildCourseCards(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
