import 'package:academia/exports/barrel.dart';
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

  void runToolFilter(String enteredKeyWord) {
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: true,
            snap: true,
            expandedHeight: 120,
            flexibleSpace: const FlexibleSpaceBar(
              title: Text("Tools"),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Tools"),
                        content: const Text(
                          "From calculating your hypothetical gpa to booking your ride, weve got you covered",
                        ),
                        actions: [
                          FilledButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Oh, ok"))
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Ionicons.information_circle),
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(8),
            sliver: SliverFillRemaining(
              hasScrollBody: true,
              child: ListView.builder(
                itemCount: _allTools.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: ToolCard(
                      heading: _allTools[index]["name"],
                      description: _allTools[index]["description"],
                      image: _allTools[index]["image"],
                      ontap: _allTools[index]["ontap"],
                      action: _allTools[index]["action"],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
