class Files {
  final String title;
  final String filePath;
  final int avgScore;

  Files({
    required this.title,
    required this.filePath,
    required this.avgScore,
  });

  factory Files.fromJson(Map<String, dynamic> json) {
    return Files(
      title: json["title"],
      filePath: json['filePath'],
      avgScore: json['avgScore'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'filePath': filePath,
      'avgScore': avgScore,
    };
  }
}
