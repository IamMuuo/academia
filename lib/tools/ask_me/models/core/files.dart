class Files {
  final int id;
  final String title;
  final String filePath;
  int avgScore;

  Files({
    required this.id,
    required this.title,
    required this.filePath,
    required this.avgScore
  });

  factory Files.fromJson(Map<String, dynamic> json) {
    return Files(
      id: json["id"],
      title: json["title"],
      filePath: json['filePath'],
      avgScore: json['avgScore'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'filePath': filePath,
      'avgScore': avgScore,
    };
  }
}
