import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/unit.dart';
import '../controllers/gpacalculator_controller.dart';

class UnitForm extends StatelessWidget {
  const UnitForm({
    super.key,
    this.unit,
    this.index,
  });
  final Unit? unit;
  final int? index;
  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: unit != null ? unit!.name : "");
    final TextEditingController creditHoursController = TextEditingController(
      text: unit != null ? unit!.creditHours.toString() : "3.0",
    );
    final TextEditingController gradeController = TextEditingController(
      text: unit != null ? unit!.grade.toString() : "A",
    );
    final GPACalculatorController gpaCalculatorController =
        Get.find<GPACalculatorController>();

    return Container(
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
              unit == null
                  ? FilledButton(
                      onPressed: () {
                        final name = nameController.text;
                        final creditHours = creditHoursController.text;
                        final grade = gradeController.text;
                        if (name.isNotEmpty &&
                            creditHours.isNotEmpty &&
                            grade.isNotEmpty &&
                            gpaCalculatorController.testValidGrade(grade)) {
                          gpaCalculatorController.addCourse(
                              name, creditHours, grade);
                          Navigator.pop(context);
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Invalide input"),
                              content: const Text(
                                "Please ensure all fields are filled and a valid grade is entered",
                              ),
                              actions: [
                                FilledButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ok"),
                                )
                              ],
                            ),
                          );
                        }
                      },
                      child: const Text("Add unit"),
                    )
                  : FilledButton(
                      onPressed: () {
                        final name = nameController.text;
                        final creditHours = creditHoursController.text;
                        final grade = gradeController.text;
                        if (name.isNotEmpty &&
                            creditHours.isNotEmpty &&
                            grade.isNotEmpty &&
                            gpaCalculatorController.testValidGrade(grade)) {
                          gpaCalculatorController.updateCourse(
                              index: index!,
                              newName: nameController.text,
                              newCreditHours: creditHoursController.text,
                              newGrade: gradeController.text);
                          Navigator.pop(context);
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
                      child: const Text("Update Unit"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
