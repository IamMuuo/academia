class Todo {
  final int? id;
  final String name;
  final DateTime date;
  final String notificationTime;
  final String notificationFrequency;
  final String color;
  final String description;
  final bool complete;
  final DateTime dateAdded;

  Todo({
    this.id,
    required this.name,
    required this.date,
    required this.notificationTime,
    required this.notificationFrequency,
    required this.color,
    required this.description,
    required this.complete,
    DateTime? dateAdded,
  }) : dateAdded = dateAdded ?? DateTime.now();

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int?,
      name: json['name'] as String,
      date: DateTime.parse(json['date']),
      notificationTime: json['notificationTime'],
      notificationFrequency: json['notificationFrequency'] as String,
      color: json['color'] as String,
      description: json['description'] as String,
      complete: json['complete'] as bool,
      dateAdded: DateTime.parse(json['dateAdded']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'notificationTime': notificationTime,
      'notificationFrequency': notificationFrequency,
      'color': color,
      'description': description,
      'complete': complete,
      'dateAdded': dateAdded.toIso8601String(),
    };
  }
}
