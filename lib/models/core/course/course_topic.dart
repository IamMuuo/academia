class CourseTopic {
  final String course;
  final String name;
  final String description;

  CourseTopic({
    required this.course,
    required this.name,
    required this.description,
  });

  factory CourseTopic.fromJson(Map<String, dynamic> json) {
    return CourseTopic(
      course: json["course"],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'course': course,
      'name': name,
      'description': description,
    };
  }
}
