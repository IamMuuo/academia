class ChirpUser {
  final String id;
  final String password;
  final DateTime? lastLogin;
  final bool isSuperuser;
  final String username;
  final bool isStaff;
  final bool isActive;
  final DateTime dateJoined;
  final String email;
  final String? profilePhoto;
  final String firstName;
  final String lastName;
  final int upvotes;

  ChirpUser({
    required this.id,
    required this.password,
    this.lastLogin,
    required this.isSuperuser,
    required this.username,
    required this.isStaff,
    required this.isActive,
    required this.dateJoined,
    required this.email,
    this.profilePhoto,
    required this.firstName,
    required this.lastName,
    required this.upvotes,
  });

  // Factory method to create a ChirpUser instance from JSON
  factory ChirpUser.fromJson(Map<String, dynamic> json) {
    return ChirpUser(
      id: json['id'] as String,
      password: json['password'] as String,
      lastLogin: json['last_login'] != null
          ? DateTime.parse(json['last_login'])
          : null,
      isSuperuser: json['is_superuser'] as bool,
      username: json['username'] as String,
      isStaff: json['is_staff'] as bool,
      isActive: json['is_active'] as bool,
      dateJoined: DateTime.parse(json['date_joined'] as String),
      email: json['email'] as String,
      profilePhoto: json['profile_url'] as String?,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      upvotes: json['upvotes'] as int,
    );
  }

  // Method to convert ChirpUser instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'password': password,
      'last_login': lastLogin?.toIso8601String(),
      'is_superuser': isSuperuser,
      'username': username,
      'is_staff': isStaff,
      'is_active': isActive,
      'date_joined': dateJoined.toIso8601String(),
      'email': email,
      'profile_photo': profilePhoto,
      'first_name': firstName,
      'last_name': lastName,
      'upvotes': upvotes,
    };
  }
}
