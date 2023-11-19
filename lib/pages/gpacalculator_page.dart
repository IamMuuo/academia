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
              "Enter your grades and credit hours for each course and press Calculate to work out your GPA.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: const Text("Load Registered Units")),
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
              child: SingleChildScrollView(
                child: Obx(() => ListView.builder(
                      itemCount: unitController.courseList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final unit = unitController.courseList[index];
                        return ListTile(
                          title: Text(unit.name),
                          subtitle: Text(unit.code),
                          trailing: Text(unit.grade),
                          onTap: () {
                            nameController.text = unit.name;
                            codeController.text = unit.code;
                            creditHoursController.text =
                                unit.creditHours.toString();
                            gradeController.text = unit.grade;

                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Flex(
                                direction: Axis.vertical,
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
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
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Unit Code',
                                              ),
                                              controller: codeController,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
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
                                                      unitController.updateCourse(
                                                          index: index,
                                                          newName:
                                                              nameController
                                                                  .text,
                                                          newCode:
                                                              codeController
                                                                  .text,
                                                          newCreditHours:
                                                              creditHoursController
                                                                  .text,
                                                          newGrade:
                                                              gradeController
                                                                  .text);
                                                      Get.back();
                                                    },
                                                    child:
                                                        const Text("Edit unit"),
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
                                                    child: const Text(
                                                        "Remove Unit"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )),
              ),
            ),
            FloatingActionButton(
                onPressed: () {
                  nameController.text = "";
                  codeController.text = "";
                  creditHoursController.text = "";
                  gradeController.text = "";
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Flex(
                      direction: Axis.vertical,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
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
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Unit Code',
                                    ),
                                    controller: codeController,
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
                                    final code = codeController.text;
                                    final creditHours =
                                        creditHoursController.text;

                                    // if (creditHours is! double) {
                                    //   Get.snackbar("Invalid Credit hours",
                                    //       "Must be a number");
                                    // }
                                    final grade = gradeController.text;
                                    if (nameController.text != '' &&
                                        codeController.text != '' &&
                                        creditHoursController.text != '' &&
                                        gradeController.text != '') {
                                      if (GPACalculatorController
                                          .testValidGrade(grade)) {
                                        unitController.addCourse(
                                            name, code, creditHours, grade);
                                        Get.back();
                                      } else {
                                        Get.defaultDialog(
                                          title: "Invalid Grade",
                                          content: const Text(
                                              "Please enter a valid grade"),
                                        );
                                      }
                                    }
                                  },
                                  child: const Text("Add unit"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: const Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
