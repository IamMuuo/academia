import 'package:academia/exports/barrel.dart';

class Membership {
  final int id;
  final ChirpUser user;
  final Organization organization;
  final String role;

  Membership({
    required this.id,
    required this.user,
    required this.organization,
    required this.role,
  });

  // Factory method to create an instance from JSON
  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      id: json['id'],
      user: ChirpUser.fromJson(json['user']),
      organization: Organization.fromJson(json['organization']),
      role: json['role'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'organization': organization.toJson(),
      'role': role,
    };
  }
}
