import 'dart:convert';

class Todo {
  int? id;
  String name;
  bool complete;
  bool notify;
  String description;
  Map<String, bool>? subTasks;
  DateTime due;
  DateTime dateAdded;
  DateTime? dateCompleted;

  Todo({
    this.id,
    required this.name,
    this.subTasks,
    required this.complete,
    required this.description,
    required this.due,
    required this.dateAdded,
    this.dateCompleted,
    this.notify = false,
  });
  // Method to convert Todo object to JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sub_tasks': json.encode(subTasks),
      'complete': complete ? 1 : 0,
      'notify': notify ? 1 : 0,
      'description': description,
      'due': due.toIso8601String(),
      'dateAdded': dateAdded.toIso8601String(),
      'dateCompleted': dateCompleted?.toIso8601String(),
    };
  }

  // Factory method to create a Todo object from a JSON Map
  factory Todo.fromJson(Map<String, dynamic> data) {
    return Todo(
      id: data['id'],
      name: data['name'],
      subTasks: json.decode(data["sub_tasks"]).cast<String, bool>(),
      complete: data['complete'] == 1 ? true : false,
      notify: data['notify'] == 1 ? true : false,
      description: data['description'],
      due: DateTime.parse(data['due']),
      dateAdded: DateTime.parse(data['dateAdded']),
      dateCompleted: data['dateCompleted'] != null
          ? DateTime.parse(data['dateCompleted'])
          : null,
    );
  }
}
