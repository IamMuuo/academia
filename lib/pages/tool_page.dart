import 'package:academia/exports/barrel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  var settingsController = Get.find<SettingsController>();
  final UserController userController = Get.find<UserController>();
  // all available tools
  final List<Map<String, dynamic>> _allTools = allTools;

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

  bool get isBirthDay {
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    var dob = inputFormat.parse(
      userController.user.value!.dateOfBirth.toString(),
    );

    if (dob.day == DateTime.now().day && dob.month == DateTime.now().month) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tools"),
        centerTitle: true,
        leading: settingsController.settings.value!.showProfilePicture ?? false
            ? isBirthDay
                ? IconButton(
                    onPressed: () {
                      Get.to(const BirthDayPage());
                    },
                    icon: const Icon(Icons.cake))
                : null
            : null,
        actions: [
          IconButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Information",
                content: Column(
                  children: [
                    Image.asset("assets/images/bot_love.png", height: 100),
                    const Text(
                      "From calculating your GPA to generating your tokens, tools are the bare essentials",
                    )
                  ],
                ),
              );
            },
            icon: const Icon(CupertinoIcons.info),
          ),
        ],
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
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  hintText: "GPA Calculator",
                  label: Text("Search for a tool"),
                  suffixIcon: Icon(CupertinoIcons.search),
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
                          image: foundTools[index]["image"],
                          ontap: foundTools[index]["ontap"],
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
