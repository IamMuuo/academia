import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
  bool _searchComplete = false;
  List<Exam> searchedExams = [];
  String filter = 'All';

  int todayCount = 0;
  int tomorrowCount = 0;
  int thisWeekCount = 0;
  int completedCount = 0;

  @override
  void initState() {
    super.initState();
    controller.hasExams.listen((hasExams) {
      if (hasExams || !hasExams) {
        calculateCounts();
      }
    });
  }

  void calculateCounts() {
    final now = DateTime.now();

    todayCount = controller.exams
          .where((exam) =>
              getExamDate(exam).isSameDate(DateTime.now()))
          .length;

    tomorrowCount = controller.exams
        .where((exam) =>
            getExamDate(exam).isSameDate(now.add(Duration(days: 1))))
        .length;

    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(Duration(days: 6));

    thisWeekCount = controller.exams
        .where((exam) =>
            getExamDate(exam)
                .isAfter(startOfWeek.subtract(Duration(days: 1))) &&
            getExamDate(exam).isBefore(endOfWeek.add(Duration(days: 1))))
        .length;

    completedCount = controller.exams
        .where((exam) => getExamDate(exam).isBefore(now))
        .length;

    setState(() {});
  }

  List<Exam> filteredExams() {
    final now = DateTime.now();
    if (filter == 'Today') {
      return controller.exams
          .where((exam) => getExamDate(exam).isSameDate(now))
          .toList();
    } else if (filter == 'Tomorrow') {
      return controller.exams
          .where((exam) =>
              getExamDate(exam).isSameDate(now.add(Duration(days: 1))))
          .toList();
    } else if (filter == 'This Week') {
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      final endOfWeek = startOfWeek.add(Duration(days: 6));

      return controller.exams
          .where((exam) =>
              getExamDate(exam)
                  .isAfter(startOfWeek.subtract(Duration(days: 1))) &&
              getExamDate(exam).isBefore(endOfWeek.add(Duration(days: 1))))
          .toList();
    } else if (filter == 'Completed') {
      return controller.exams
          .where((exam) => getExamDate(exam).isBefore(now))
          .toList();
    } else {
      return controller.exams;
    }
  }


  DateTime getExamDate(Exam exam) {
    final formatter = DateFormat('EEEE dd/MM/yy');
    return formatter.parse(exam.day.title());
  }

  

  

  @override
  Widget build(BuildContext context) {
    final totalCounts = [
      todayCount,
      tomorrowCount,
      thisWeekCount,
      completedCount,
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            title: Text(
              "Hi ${userController.user.value!.firstName.title()}",
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Get.defaultDialog(
                    title: "Academia Help",
                    content: const Text(
                      "Never miss an exam again with the intuitive exam timetable\nDouble tap an exam card to remove it",
                    ),
                  );
                },
                icon: const Icon(Ionicons.help),
              ),
            ],
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                ),
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: () => controller.previousQuote(),
                  onDoubleTap: () => controller.nextQuote(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 60),
                      const Spacer(),
                      Obx(
                        () => Text(
                          controller.index > -1
                              ? controller.quotes[controller.index.value]["q"]
                              : "Fool me once shame on you; fool me twice, shame on me.",
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
                              : "Chinese Proverb",
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(
              () => controller.hasExams.value
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: ExamCountDownWidget(
                        examCount: controller.exams.length,
                        exam: controller.exams[0],
                        endtime: getExamDate(controller.exams[0]),
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 1.5,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final filterOptions = [
                    'Today',
                    'Tomorrow',
                    'This Week',
                    'Completed'
                  ];
                  final colors = [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.tertiary,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.secondaryContainer,
                  ];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        filter = filterOptions[index];
                      });
                    },
                    child: Card(
                      color: colors[index],
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              totalCounts[index].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              filterOptions[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Obx(
                () => controller.hasExams.value
                    ? ListView.builder(
                        itemCount: filteredExams().length,
                        itemBuilder: (context, index) => GestureDetector(
                          onDoubleTap: () async {
                            await controller
                                .removeExamFromStorage(filteredExams()[index]);
                            controller.hasExams.refresh();
                          },
                          child: Opacity(
                            opacity: getExamDate(filteredExams()[index])
                                    .isBefore(DateTime.now())
                                ? 0.5
                                : 1.0,
                            child: ExamCard(exam: filteredExams()[index]),
                          ),
                          
                        ),
                      )
                    : Center(
                        child: Text(
                          "Who dares summon me?🧞",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                fontFamily: GoogleFonts.figtree().fontFamily,
                              ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
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
                                Get.snackbar(
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
                              if (mounted) {
                                setState(() {
                                  _isSearching = true;
                                  _searchComplete = false;
                                });
                                searchedExams = await controller.fetchExams(
                                  _searchController.text.split(","),
                                );

                                if (searchedExams.isNotEmpty) {
                                  setState(() {
                                    _searchComplete = true;
                                  });
                                }

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
                          ? Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Theme.of(context)
                                    .colorScheme
                                    .tertiaryContainer,
                              ),
                              child: Text(
                                "Your wish is my command. Performing forbidden magic 🧞\n Double Tap a course to add it",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(
                                      fontFamily:
                                          GoogleFonts.figtree().fontFamily,
                                    ),
                              ),
                            )
                          : _searchComplete
                              ? SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: ListView.builder(
                                    itemCount: searchedExams.length,
                                    itemBuilder: (context, index) =>
                                        GestureDetector(
                                      onDoubleTap: () async {
                                        await controller.addExamToStorage(
                                            searchedExams[index]);
                                        searchedExams.removeAt(index);
                                        controller.hasExams.refresh();
                                        setState(() {});
                                      },
                                      child: ExamCard(
                                        exam: searchedExams[index],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiaryContainer,
                                  ),
                                  child: Text(
                                    "Please input your units separated with commas and let the genie work his forbidden magic!",
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
        child: const Icon(Ionicons.search),
      ),
    );
  }

  


  Widget _buildFilterCard(BuildContext context, String title, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          filter = title;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.width * 0.2,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            title,
          ),
        ),
      ),
    );
  }
}
extension DateHelpers on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
