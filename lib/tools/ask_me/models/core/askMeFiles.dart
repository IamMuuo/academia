class AskMeFiles {
  int? id;
  final String title;
  final String filePath;
  int avgScore;

  AskMeFiles({
    this.id,
    required this.title,
    required this.filePath,
    required this.avgScore,
  });

  factory AskMeFiles.fromJson(Map<String, dynamic> json) {
    return AskMeFiles(
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
