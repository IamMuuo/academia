import 'package:academia/widgets/tool_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  // all available tools
  final List<Map<String, dynamic>> _allTools = [
    {
      "id": 1,
      "name": "GPA Calculator",
      "action": "Calculate GPA",
      "description": "Wanna calculate your GPA? try it here"
    },
    {
      "id": 2,
      "name": "Generate Catering Token",
      "action": "Generate Token",
      "description": "Hungry? Maybe its time to generate your catering token!"
    },
    {
      "id": 3,
      "name": "Elearning",
      "action": "Visit Elearning",
      "description":
          "Psst! Elearning is here for you. Keep track of your assignments and notes!",
    },
    {
      "id": 4,
      "name": "Class Attendance",
      "action": "View class Attendance",
      "description":
          "Curious to know how many classes you have missed this semester, this might be the tool",
    },
    {
      "id": 5,
      "name": "Exam Timetable",
      "action": "Show exam timetable",
      "description":
          "Exams around the corner? Don't panic we've got you covered with the timetable",
    },
  ];

  List<Map<String, dynamic>> foundTools = [];

  @override
  void initState() {
    super.initState();
    // At the beginning all tools are visible
    foundTools = _allTools;
  }

  void _runToolFilter(String enteredKeyWord) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyWord.isEmpty) {
      results = _allTools;
    } else {
      results = _allTools
          .where((element) => element["name"]
              .toString()
              .toLowerCase()
              .contains(enteredKeyWord.toLowerCase()))
          .toList();
    }

    // refresh the ui
    setState(() {
      foundTools = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tools"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8, left: 12, right: 12),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: TextField(
                onChanged: (value) => _runToolFilter(value),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  hintText: "GPA Calculator",
                  label: const Text("Search for a tool"),
                  suffix: IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.search_circle_fill),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: foundTools.isNotEmpty
                  ? ListView.builder(
                      itemCount: foundTools.length,
                      itemBuilder: (context, index) {
                        return ToolCard(
                          heading: foundTools[index]["name"],
                          description: foundTools[index]["description"],
                          image: "assets/images/bot_sad.png",
                          ontap: () {},
                          action: foundTools[index]["action"],
                        );
                      },
                    )
                  : Column(
                      children: [
                        const Text(
                          "We can't find that requested tool at the moment. Please try using alternative keywords or",
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text("Tap to request this feature")),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
