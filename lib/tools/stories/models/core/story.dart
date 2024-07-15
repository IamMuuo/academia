/// The story model
/// Represents a story
class Story {
  String id;
  String organizationId;
  String hexCode;
  String text;
  String? media;
  bool? viewed;
  DateTime dateAdded;
  DateTime dateOfExpiry;

  Story({
    required this.id,
    required this.organizationId,
    required this.hexCode,
    required this.text,
    this.media,
    this.viewed,
    required this.dateAdded,
    required this.dateOfExpiry,
  });

  factory Story.fromJson(Map<String, dynamic> json) {
    final isViewed = json['viewed'] is int
        ? json['viewed'] == 1
            ? true
            : false
        : json['viewed'];
    return Story(
      id: json['id'],
      organizationId: json['organization'],
      hexCode: json['hex_code'],
      text: json['text'],
      media: json['media'],
      viewed: isViewed,
      dateAdded: DateTime.parse(json['date_added']),
      dateOfExpiry: DateTime.parse(json['date_of_expiry']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organization': organizationId,
      'hex_code': hexCode,
      'text': text,
      'media': media,
      'viewed': viewed != null
          ? viewed == true
              ? 1
              : 0
          : 0,
      'date_added': dateAdded.toIso8601String(),
      'date_of_expiry': dateOfExpiry.toIso8601String(),
    };
  }
}
