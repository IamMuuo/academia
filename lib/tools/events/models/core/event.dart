class Event {
  String id;
  DateTime dateAdded;
  String name;
  String phone;
  String email;
  String location;
  int likes;
  String description;
  String media;
  String mediaType;
  String? url;
  DateTime startDate;
  DateTime endDate;

  Event({
    required this.id,
    required this.dateAdded,
    required this.name,
    required this.phone,
    required this.email,
    required this.location,
    required this.likes,
    required this.description,
    required this.media,
    required this.mediaType,
    this.url,
    required this.startDate,
    required this.endDate,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      dateAdded: DateTime.parse(json['date_added']),
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      location: json['location'],
      likes: json['likes'],
      description: json['description'],
      media: json['media'],
      mediaType: json['media_type'],
      url: json['url'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date_added': dateAdded.toIso8601String(),
      'name': name,
      'phone': phone,
      'email': email,
      'location': location,
      'likes': likes,
      'description': description,
      'media': media,
      'media_type': mediaType,
      'url': url,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
    };
  }
}
