import 'dart:ui';

class Todo {
  int? id;
  String name;
  Color color; // Using dart:ui Color
  bool complete;
  String description;
  DateTime due;
  DateTime dateAdded;
  DateTime? dateCompleted;

  Todo({
    this.id,
    required this.name,
    required this.color,
    required this.complete,
    required this.description,
    required this.due,
    required this.dateAdded,
    this.dateCompleted,
  });

  // Helper method to convert Color to int
  int _colorToInt(Color color) {
    return color.value;
  }

  // Helper method to convert int to Color
  static Color _intToColor(int value) {
    return Color(value);
  }

  // Method to convert Todo object to JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': _colorToInt(color),
      'complete': complete ? 1 : 0,
      'description': description,
      'due': due.toIso8601String(),
      'dateAdded': dateAdded.toIso8601String(),
      'dateCompleted': dateCompleted?.toIso8601String(),
    };
  }

  // Factory method to create a Todo object from a JSON Map
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      name: json['name'],
      color: _intToColor(json['color']),
      complete: json['complete'] == 1 ? true : false,
      description: json['description'],
      due: DateTime.parse(json['due']),
      dateAdded: DateTime.parse(json['dateAdded']),
      dateCompleted: json['dateCompleted'] != null
          ? DateTime.parse(json['dateCompleted'])
          : null,
    );
  }
}
