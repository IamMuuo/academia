/// Organization

// The organization class represents the various organizations in the school
class Organization {
  String id;
  String name;
  String phone;
  String email;
  String description;
  String profile;
  DateTime dateAdded;

  Organization({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.description,
    required this.profile,
    required this.dateAdded,
  });

  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      description: json['description'],
      profile: json['profile'],
      dateAdded: DateTime.parse(json['date_added']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'description': description,
      'profile': profile,
      'date_added': dateAdded.toIso8601String(),
    };
  }
}
