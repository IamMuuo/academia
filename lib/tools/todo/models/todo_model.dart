class Todo {
  final int? id;
  final String title;
  final DateTime date;
  final DateTime remindDate;
  final String color;
  final String pictureAttachment;
  final String note;

  Todo({
    this.id,
    required this.title,
    required this.date,
    required this.remindDate,
    required this.color,
    required this.pictureAttachment,
    required this.note,
  });

  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      date: DateTime.parse(json['date']),
      remindDate: DateTime.parse(json['remindDate']),
      color: json['color'],
      pictureAttachment: json['pictureAttachment'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'date': date.toIso8601String(),
      'remindDate': remindDate.toIso8601String(),
      'color': color,
      'pictureAttachment': pictureAttachment,
      'note': note,
    };
  }
}
