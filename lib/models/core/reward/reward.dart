import 'package:intl/intl.dart';
export 'reward_helper.dart';

class Reward {
  String? id;
  String studentId;
  int points;
  String reason;
  DateTime awardedAt;

  Reward({
    this.id,
    required this.studentId,
    required this.points,
    required this.reason,
    required this.awardedAt,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['id'],
      studentId: json['student_id'],
      points: json['points'],
      reason: json['reason'],
      awardedAt: DateTime.parse(json['awarded_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_id': studentId,
      'points': points,
      'reason': reason,
      'awarded_at': DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(
        awardedAt.toUtc(),
      ),
    };
  }
}
