class AskMeScores {
  int? id;
  final int score;
  final int filesId; 

  AskMeScores({
    this.id,
    required this.score,
    required this.filesId,
  });


  factory AskMeScores.fromJson(Map<String, dynamic> json) {
    return AskMeScores(
      id: json['id'],
      score: json['score'],
      filesId: json['filesId'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'score': score,
      'filesId': filesId,
    };
  }
}
