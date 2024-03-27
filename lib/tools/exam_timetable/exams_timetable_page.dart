import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/exam_timetable/exams_timetable_controller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class ExamTimeTablePage extends StatefulWidget {
  const ExamTimeTablePage({super.key});

  @override
  State<ExamTimeTablePage> createState() => _ExamTimeTablePageState();
}

class _ExamTimeTablePageState extends State<ExamTimeTablePage> {
  final userController = Get.find<UserController>();
  final settingsController = Get.find<SettingsController>();
  final controller = Get.put(ExamsTimeTableController());
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(
              "Hi ${userController.user.value!.name!.split(' ')[0].title()}",
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Ionicons.help),
              ),
            ],
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onPanUpdate: ((details) {
                    if (details.delta.dx > 0) {
                      controller.nextQuote();
                    }

                    if (details.delta.dx < 0) {
                      controller.previousQuote();
                    }
                  }),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 60),
                      const Spacer(),
                      Obx(
                        () => Text(
                          controller.index > -1
                              ? controller.quotes[controller.index.value]["q"]
                              : "So long as we are being remembered, we remain alive.",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                fontFamily: GoogleFonts.figtree().fontFamily,
                              ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          controller.index > -1
                              ? controller.quotes[controller.index.value]["a"]
                              : "Carlos Ruiz Zafon",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Seems you have no exams at the moment",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontFamily: GoogleFonts.figtree().fontFamily,
                        ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isDismissible: false,
            context: context,
            builder: (context) => StatefulBuilder(
              builder: (context, StateSetter setState) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "BIL 111K, ENG 112, ...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              if (_searchController.text.trim().isEmpty) {
                                showCustomSnackbar(
                                  "Error",
                                  "Please provide units to search",
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                  colorText:
                                      Theme.of(context).colorScheme.onSurface,
                                );
                                return;
                              }
                              print("Here");
                              if (mounted) {
                                setState(() {
                                  _isSearching = true;
                                });

                                // await examtimetableController.fetchExams();
                                if (!mounted) {
                                  return;
                                }
                                setState(() {
                                  _isSearching = false;
                                });
                              }
                            },
                            icon: const Icon(Ionicons.search),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _isSearching
                          ? const Text("Loading")
                          : Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                              ),
                              child: Text(
                                "Please input your units seperated with commas and wait for the magic to happen🪄",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontFamily:
                                          GoogleFonts.figtree().fontFamily,
                                    ),
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          );
        },
        child: const Icon(
          Ionicons.add,
        ),
      ),
    );
  }
}
