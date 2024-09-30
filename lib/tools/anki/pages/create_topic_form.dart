import 'package:academia/tools/anki/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/models.dart';

class CreateTopicForm extends StatelessWidget {
  const CreateTopicForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    final TopicController topicController = Get.find<TopicController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create a topic",
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                maxLength: 20,
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Write a description for your topic",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: descController,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: "Write a description for your topic",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              FilledButton(
                onPressed: () {
                  if (titleController.text.trim().isEmpty ||
                      descController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("All Above Fields are required"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  } else if (titleController.text.trim().length <= 3) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Topic Length should be more than 2 characters"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  } else if (descController.text.trim().length <= 12) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Desc Length should be more than 11 characters"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  } else {
                    // create topic
                    AnkiTopic ankiTopic = AnkiTopic(
                      name: titleController.text,
                      desc: descController.text,
                    );
                    // add to database
                    if (topicController.numTopics() <= 5) {
                      ankiTopic.isFavourite = true;
                    }
                    topicController.addTopic(ankiTopic);

                    if (topicController.numTopics() < 5) {
                      // updating favourites
                      topicController.getAllFavourites();
                    }
                    // updating topic list and favorites
                    topicController.getAllTopics();
                    topicController.getAllFavourites();
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("Create topic"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
