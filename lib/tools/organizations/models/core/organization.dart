class Organization {
  final String id;
  final String name;
  final String email;
  final bool active;
  final String? description;
  final String? logo;
  final String? banner;
  final String? organizationPage;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String owner;
  final String location;
  final String phone;

  Organization({
    required this.id,
    required this.name,
    required this.email,
    required this.active,
    this.description,
    this.logo,
    this.banner,
    this.organizationPage,
    this.createdAt,
    this.updatedAt,
    required this.owner,
    required this.location,
    required this.phone,
  });

  // Factory method to create an instance from JSON
  factory Organization.fromJson(Map<String, dynamic> json) {
    return Organization(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      active: json['active'],
      description: json['description'],
      logo: json['logo'],
      banner: json['banner'],
      organizationPage: json['organization_page'],
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      owner: json['owner'],
      location: json['location'],
      phone: json['phone'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'active': active,
      'description': description,
      'logo': logo,
      'banner': banner,
      'organization_page': organizationPage,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'owner': owner,
      'location': location,
      'phone': phone,
    };
  }
}
