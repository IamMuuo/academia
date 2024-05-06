class Todo {
  final int? id;
  final String name;
  final DateTime date;
  final String notificationTime;
  final bool notificationFrequency;
  final String color;
  final String description;
  final bool complete;
  final DateTime dateAdded;
  final DateTime? dateCompleted;

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
    this.dateCompleted,
  }) : dateAdded = dateAdded ?? DateTime.now();

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as int?,
      name: json['name'] as String,
      date: DateTime.parse(json['date']),
      notificationTime: json['notification_time'],
      notificationFrequency:
          (json['notification_frequency'] ?? 0) == 1 ? true : false,
      color: json['color'] as String,
      description: json['description'] as String,
      complete: (json['complete'] ?? 0) == 0 ? false : true,
      dateAdded: DateTime.parse(json['date_added']),
      dateCompleted: DateTime.tryParse(json['date_completed'] ?? ""),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'date': date.toIso8601String(),
      'notification_time': notificationTime,
      'notification_frequency': notificationFrequency == true ? 1 : 0,
      'color': color,
      'description': description,
      'complete': complete == true ? 1 : 0,
      'date_added': dateAdded.toIso8601String(),
      'date_completed': dateCompleted?.toIso8601String(),
    };
  }
}
