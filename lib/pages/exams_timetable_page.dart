import 'package:academia/constants/common.dart';
import 'package:academia/models/courses.dart';
import 'package:academia/widgets/academia_app_bar.dart';
import 'package:academia/widgets/count_down_widget.dart';
import 'package:academia/widgets/exam_course_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ExamTimeTablePage extends StatefulWidget {
  const ExamTimeTablePage({super.key});

  @override
  State<ExamTimeTablePage> createState() => _ExamTimeTablePageState();
}

class _ExamTimeTablePageState extends State<ExamTimeTablePage> {
  bool _isLoading = false;
  bool _hasExams = false;
  var _searchedUnits = [];
  var _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _isLoading = appDB.get("exam_timetable").isEmpty;
    return Scaffold(
      body: FutureBuilder(
        future: fetchCoreUnits(),
        builder: (context, snapshot) => !snapshot.hasData
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/having_coffee.png"),
                  const Text(
                    "Exam magic in progress 😜",
                  ),
                  LoadingAnimationWidget.hexagonDots(
                    size: 40,
                    color: Theme.of(context).primaryColorDark,
                  )
                ],
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                    child: Column(
                      children: [
                        AcademiaAppBar(
                          title: DateTime.now().hour < 11
                              ? "Good Morning"
                              : DateTime.now().hour < 13
                                  ? "Good Afternoon"
                                  : "Good Evening",
                          subtitle:
                              "Are you ready ${(user.name!.split(" ")[0]).title().trim()}?",
                          icon: const Icon(
                              CupertinoIcons.arrowshape_turn_up_left),
                          ontapped: () => Get.back(),
                        ),

                        // The actual body
                        CountDown(
                          deadline: DateTime.now().add(const Duration(
                              hours: 10, minutes: 7, seconds: 12)),
                        ),
                        const SizedBox(height: 16),

                        FlutterCarousel(
                          items:
                              buildCauroselItems(context, hasExams: _hasExams),
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.25,
                            autoPlayCurve: Curves.easeInSine,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            indicatorMargin: 2,
                            slideIndicator: CircularSlideIndicator(
                              itemSpacing: 12,
                              indicatorBorderColor:
                                  Theme.of(context).primaryColorDark,
                              indicatorRadius: 5,
                              // indicatorBackgroundColor: Colors.red,
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        !_isLoading
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: ListView.builder(
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: ExamCourseCard(
                                      ontap: () {
                                        print("Hi");
                                      },
                                      code: snapshot.data![index]["course_code"]
                                          .toString(),
                                      date: DateFormat('EEE dd/MM/yy').format(
                                          DateFormat('dd/MM/yy').parse(snapshot
                                              .data![index]["day"]
                                              .toString()
                                              .split(" ")[1])),
                                      venue: snapshot.data![index]["room"]
                                          .toString(),
                                      time: snapshot.data![index]["time"]
                                          .toString(),
                                    ),
                                  ),
                                ),
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      LoadingAnimationWidget.halfTriangleDot(
                                        color:
                                            Theme.of(context).primaryColorDark,
                                        size: 40,
                                      ),
                                      Text(
                                        "Updating your view",
                                        style: normal.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ]),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: "BIL 112B, MATH 120A, ...",
                              label: const Text("Please input units to find"),
                              suffix: IconButton(
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  _searchedUnits = await fetchExamTimeTable(
                                      _searchController.text);
                                  setState(() {
                                    _isLoading = false;
                                  });
                                },
                                icon: const Icon(
                                    CupertinoIcons.search_circle_fill),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                top: 20, left: 8, right: 8),
                            child: !_isLoading
                                ? Column(
                                    children: [
                                      Image.asset("assets/images/view.png",
                                          width: 200),
                                      const Text(
                                          "Input your units and let us do the heavy lifting")
                                    ],
                                  )
                                : LoadingAnimationWidget.hexagonDots(
                                    color: Theme.of(context).primaryColorDark,
                                    size: 40,
                                  )),
                      ],
                    ),
                  ),
                );
              });
        },
        tooltip: "Add a unit",
        backgroundColor: Theme.of(context).primaryColorDark,
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }

  // Method to add the caurosel
  List<Widget> buildCauroselItems(
    BuildContext context, {
    bool hasExams = false,
  }) {
    var items = <Widget>[];

    if (!hasExams) {
      items.add(
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                "assets/images/bot_sad.png",
                scale: 0.2,
                height: 120,
              ),
              Text(
                "It seems you have no upcoming exams",
                textAlign: TextAlign.center,
                style: normal.copyWith(
                  color: Theme.of(context).primaryColorLight,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );

      items.add(
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                "assets/images/bot_search.png",
                scale: 0.2,
                height: 120,
              ),
              Text(
                "Please tap on the + button to find and add",
                textAlign: TextAlign.center,
                style:
                    normal.copyWith(color: Theme.of(context).primaryColorLight),
              ),
            ],
          ),
        ),
      );
    } else {
      var x = appDB.get("exam_timetable");
      for (var element in x) {
        debugPrint("$element");
      }
    }
    return items;
  }

  // build content cards

  Future<List<dynamic>> fetchCoreUnits() async {
    var units = await appDB.get("exam_timetable") as List<dynamic>;
    if (units.isEmpty) {
      var courses = appDB.get("timetable");
      String payload = "";
      for (Courses c in courses) {
        payload =
            "$payload ${c.name!.replaceAll("-", " ")}${c.section!.split('-')[0]},";
      }
      var fetchedUnits = await fetchExamTimeTable(payload.trim());
      await addFetchedUnits(fetchedUnits);
      _hasExams = true;
      return fetchedUnits;
    }
    return units;
  }

  Future<List<dynamic>> fetchExamTimeTable(String units,
      {bool athi = true}) async {
    setState(() {
      _isLoading = true;
    });

    try {
      var fetchedUnits = await magnet.fetchExamTimeTabale(units);
      setState(() {
        _isLoading = false;
      });

      return fetchedUnits;
    } catch (e) {
      Get.snackbar(
        "Oh Snap!",
        "Something went wrong while attempting to fetch your exam timetable, please check your network connection and try again",
        icon: const Icon(
          Icons.network_ping,
        ),
        maxWidth: 500,
      );
      debugPrint(e.toString());
    }
    setState(() {
      _isLoading = false;
    });

    return [];
  }

  Future<void> addFetchedUnits(List<dynamic> fetchedUnits) async {
    await appDB.put("exam_timetable", fetchedUnits);
  }
}
