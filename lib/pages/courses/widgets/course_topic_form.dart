import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class TopicForm extends StatefulWidget {
  const TopicForm({super.key});

  @override
  State<TopicForm> createState() => _TopicFormState();
}

class _TopicFormState extends State<TopicForm> {
  @override
  Widget build(BuildContext context) {
    final topicNameController = TextEditingController();
    final topicDescriptionController = TextEditingController();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
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
            onPressed: () {},
            label: const Text("Add Topic"),
            icon: const Icon(Ionicons.clipboard),
          )
        ],
      ),
    );
  }
}
