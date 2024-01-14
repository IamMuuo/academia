import 'package:academia/constants/common.dart';
import 'package:academia/controllers/gpacalculator_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GpaCalculator extends StatelessWidget {
  GpaCalculator({super.key});
  final tabs = [
    "Red",
    "Orange",
    "Green",
  ];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController creditHoursController = TextEditingController();
  final TextEditingController gradeController = TextEditingController();
  final unitController = GPACalculatorController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text("GPA Calculator"),
        // automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: "clear",
                  child: Text("Clear all"),
                ),
                const PopupMenuItem(
                  value: "info",
                  child: Text("Info"),
                ),
              ];
            },
            onSelected: (value) {
              if (value == "clear") {
                unitController.courseList.clear();
              }
              if (value == "info") {
                Get.defaultDialog(
                  title: "GPA Calculator 🧮",
                  content: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "The GPA calculator is a tool to help you figure out your grade point average based on Daystar University's grading system. It is meant to give you an idea of how you're doing, and what you might need to do to improve your grades.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "GPA Calculator",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "For accurate results, kindly ensure the credit hours loaded are correct for each of the units you are taking.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                    onPressed: loadRegisteredUnits,
                    child: const Text("Load Registered Units")),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    if (unitController.courseList.isEmpty) {
                      Get.defaultDialog(
                        title: "List empty",
                        content: const Text("Input Grades!"),
                      );
                      return;
                    }
                    Get.defaultDialog(
                      title: "Your GPA",
                      content:
                          Text("Your GPA is ${unitController.gpa.toString()}"),
                    );
                  },
                  child: const Text("Calculate GPA"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: unitController.courseList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final unit = unitController.courseList[index];
                      return ListTile(
                        title: Text(unit.name),
                        subtitle: Text("${unit.creditHours.toInt()} hrs"),
                        trailing: Text(unit.grade),
                        onTap: () {
                          nameController.text = unit.name;
                          // codeController.text = unit.code;
                          creditHoursController.text =
                              unit.creditHours.toString();
                          gradeController.text = unit.grade;

                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            // useSafeArea: true,
                            builder: (context) => Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        "Edit the unit details",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Unit Name',
                                          ),
                                          controller: nameController,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Credit Hours',
                                          ),
                                          controller: creditHoursController,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Grade',
                                          ),
                                          controller: gradeController,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  final name =
                                                      nameController.text;
                                                  final creditHours =
                                                      creditHoursController
                                                          .text;
                                                  final grade =
                                                      gradeController.text;
                                                  if (name.isNotEmpty &&
                                                      creditHours.isNotEmpty &&
                                                      grade.isNotEmpty &&
                                                      GPACalculatorController
                                                          .testValidGrade(
                                                              grade)) {
                                                    unitController.updateCourse(
                                                        index: index,
                                                        newName:
                                                            nameController.text,
                                                        newCreditHours:
                                                            creditHoursController
                                                                .text,
                                                        newGrade:
                                                            gradeController
                                                                .text);
                                                    Get.back();
                                                  } else {
                                                    Get.defaultDialog(
                                                      title: "Invalid input",
                                                      content: const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                            "Please ensure all fields are filled and a valid grade is entered!"),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: const Text("Edit unit"),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  unitController
                                                      .removeCourse(index);
                                                  Get.back();
                                                },
                                                child:
                                                    const Text("Remove Unit"),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )),
            ),
            FloatingActionButton(
                onPressed: () {
                  nameController.text = "";
                  codeController.text = "";
                  creditHoursController.text = "";
                  gradeController.text = "";
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    // useSafeArea: true,
                    builder: (context) => Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Enter the unit details",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Unit Name',
                                  ),
                                  controller: nameController,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Credit Hours',
                                  ),
                                  controller: creditHoursController,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Grade',
                                  ),
                                  controller: gradeController,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  final name = nameController.text;
                                  final creditHours =
                                      creditHoursController.text;
                                  final grade = gradeController.text;
                                  if (name.isNotEmpty &&
                                      creditHours.isNotEmpty &&
                                      grade.isNotEmpty &&
                                      GPACalculatorController.testValidGrade(
                                          grade)) {
                                    unitController.addCourse(
                                        name, creditHours, grade);
                                    Get.back();
                                  } else {
                                    Get.defaultDialog(
                                      title: "Invalid input",
                                      content: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                            "Please ensure all fields are filled and a valid grade is entered!"),
                                      ),
                                    );
                                  }
                                },
                                child: const Text("Add unit"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.add))
          ],
        ),
      ),
    );
  }

  void loadRegisteredUnits() {
    unitController.courseList.clear();
    final courses = appDB.get("timetable");
    if (courses == null) {
      Get.defaultDialog(
        title: "No courses found",
        content: const Text("Please register your courses first"),
      );
    }
    for (final course in courses) {
      final period = course.period.split('-');
      final startPeriod = period[0].trim().split(':');
      final endPeriod = period[1].trim().split(':');

      final startHour = int.parse(startPeriod[0]);
      final startMinute = int.parse(startPeriod[1].substring(0, 2));
      final startAmPm = startPeriod[1].substring(2).trim();

      final endHour = int.parse(endPeriod[0]);
      final endMinute = int.parse(endPeriod[1].substring(0, 2));
      final endAmPm = endPeriod[1].substring(2).trim();

      final startTime = DateTime(
          0, 0, 0, startHour + (startAmPm == 'PM' ? 12 : 0), startMinute);
      final endTime =
          DateTime(0, 0, 0, endHour + (endAmPm == 'PM' ? 12 : 0), endMinute);

      final difference = endTime.difference(startTime);
      unitController.addCourse(course.name, difference.inHours.toString(), "A");
    }
  }
}
