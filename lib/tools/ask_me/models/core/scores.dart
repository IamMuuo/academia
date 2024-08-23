class Score {
  //final int id;
  final int score;
  final int filesId; 

  Score({
    //required this.id,
    required this.score,
    required this.filesId,
  });


  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(
      //id: json['id'],
      score: json['score'],
      filesId: json['filesId'], 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //'id': id,
      'score': score,
      'filesId': filesId,
    };
  }
}
