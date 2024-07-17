import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import '../controllers/gpacalculator_controller.dart';
import '../widgets/widgets.dart';

class GpaCalculator extends StatelessWidget {
  GpaCalculator({super.key});
  final unitController = Get.put(GPACalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                onPressed: () {
                  unitController.courseList.clear();
                },
                icon: const Icon(Ionicons.close_circle_outline),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Information"),
                      content: const Text(
                        "The GPA calculator helps you to set realistic and attainable targets and also confirm your grades",
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
                },
                icon: const Icon(Ionicons.information_circle_outline),
              ),
            ],
            expandedHeight: 250,
            snap: true,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
              title: const Text("GPA Calculator"),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Text(
                "For accurate results, kindly ensure the credit hours loaded are correct for each of the units you are taking.",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilledButton(
                    onPressed: () {
                      loadRegisteredUnits();
                    },
                    child: const Text("Load Registed Courses"),
                  ),
                  FilledButton(
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
                        content: Text(
                            "Your GPA is ${unitController.gpa.toString()}"),
                      );
                    },
                    child: const Text("Calculate"),
                  ),
                ],
              ),
            ),
          ),
          Obx(
            () => SliverList.builder(
              itemBuilder: (context, index) {
                final data = unitController.courseList.elementAt(index);
                return ListTile(
                  leading: CircleAvatar(
                    child: Text((index + 1).toString()),
                  ),
                  title: Text(data.name),
                  subtitle: Text(data.creditHours.toString()),
                  trailing: Text(data.grade),
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => UnitForm(
                        unit: data,
                        index: index,
                      ),
                    );
                  },
                );
              },
              itemCount: unitController.courseList.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const UnitForm(),
          );
        },
        child: const Icon(Ionicons.add),
      ),
    );
  }

  void loadRegisteredUnits() {
    unitController.courseList.clear();
    var courseController = Get.find<CoursesController>();
    unitController.registeredCourses = courseController.courses;
    final registeredCourses = unitController.registeredCoursesList;
    debugPrint("Courses: $registeredCourses");
    for (final course in registeredCourses) {
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
      unitController.addCourse(course.unit, difference.inHours.toString(), "A");
    }
  }
}
