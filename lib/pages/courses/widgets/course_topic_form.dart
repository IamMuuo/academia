import 'package:academia/exports/barrel.dart';
import 'package:academia/models/core/course/course_model.dart';
import 'package:academia/models/core/course/course_topic.dart';
import 'package:get/get.dart';

class TopicForm extends StatelessWidget {
  const TopicForm({
    super.key,
    required this.course,
  });
  final Course course;

  @override
  Widget build(BuildContext context) {
    final CoursesController coursesController = Get.find<CoursesController>();
    final topicNameController = TextEditingController();
    final topicDescriptionController = TextEditingController();
    final formState = GlobalKey<FormState>();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: Form(
        key: formState,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Add A topic",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Container(
                padding: const EdgeInsets.all(8),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Text(
                  "Note down topics after class to help you revise for cats and exams",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.length < 3) {
                    return "Please input a valid topic name";
                  }
                  return null;
                },
                controller: topicNameController,
                decoration: InputDecoration(
                  label: const Text("Topic name"),
                  hintText: "Waves and Electromagnetism",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: topicDescriptionController,
                maxLines: 5,
                textAlignVertical: TextAlignVertical.top,
                decoration: InputDecoration(
                  label: const Text("Addittional Data"),
                  hintText: "Read topic from Scientists and Engineers book",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              FilledButton.icon(
                onPressed: () async {
                  if (!formState.currentState!.validate()) {
                    return;
                  }
                  final ok = await coursesController.createCourseTopic(
                    CourseTopic(
                        course: course.unit,
                        name: topicNameController.text,
                        description: topicDescriptionController.text),
                  );

                  if (ok) {
                    if (context.mounted) Navigator.pop(context);
                  }
                },
                label: const Text("Add Topic"),
                icon: const Icon(Ionicons.clipboard),
              )
            ],
          ),
        ),
      ),
    );
  }
}
