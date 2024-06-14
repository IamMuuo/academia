// The user model
/// Represents a user's model as well as provides
/// JSON to and fro serialization functionality
class User {
  String? id;
  String username;
  String firstName;
  String lastName;
  String admissionNumber;
  String nationalId;
  String gender;
  String address;
  String email;
  DateTime dateOfBirth;
  String campus;
  String profileUrl;
  String password;
  bool active;
  int vibePoints;
  dynamic pointTransactions; // It can be a List or any other appropriate type
  DateTime? dateCreated;
  DateTime? dateUpdated;

  User({
    this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.admissionNumber,
    required this.nationalId,
    required this.gender,
    required this.address,
    required this.email,
    required this.dateOfBirth,
    required this.campus,
    required this.profileUrl,
    required this.password,
    required this.active,
    required this.vibePoints,
    required this.pointTransactions,
    this.dateCreated,
    this.dateUpdated,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      admissionNumber: json['admission_number'],
      nationalId: json['national_id'],
      gender: json['gender'],
      address: json['address'],
      email: json['email'],
      dateOfBirth: DateTime.parse(json['date_of_birth']),
      campus: json['campus'],
      profileUrl: json['profile_url'],
      password: json['password'],
      active: json['active'],
      vibePoints: json['vibe_points'],
      pointTransactions: json['point_transactions'],
      dateCreated: DateTime.parse(json['date_created']),
      dateUpdated: DateTime.parse(json['date_updated']),
    );
  }

  /// Facilitates the creation of a user model from magnet's output
  /// You must add the user's username and password to the [magnetData]
  /// manually to facilitate the creation of a user instance
  factory User.fromMagnet(Map<String, dynamic> magnetData) {
    // Split the name into first name and last name
    String name = magnetData['name'];
    List<String> nameParts = name.split(' ');
    String firstName = nameParts.first;
    String lastName = nameParts.sublist(1).join(' ');

    DateTime dateOfBirth = DateTime.parse(magnetData['dateofbirth']);

    String admissionNumber = magnetData['regno'];
    String nationalId = magnetData['idno'];
    String gender = magnetData['gender'];
    String address = magnetData['address'];
    String email = magnetData['email'];
    String campus = magnetData['campus'];
    bool active = magnetData['academicstatus'].toLowerCase() == 'active';
    String profileUrl = magnetData['profile'];
    String password = magnetData['password'];
    String username = magnetData['username'];

    return User(
      admissionNumber: admissionNumber,
      firstName: firstName,
      lastName: lastName,
      nationalId: nationalId,
      gender: gender,
      address: address,
      email: email,
      dateOfBirth: dateOfBirth,
      campus: campus,
      active: active,
      profileUrl: profileUrl,
      pointTransactions: null,
      vibePoints: 0,
      password: password,
      username: username,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'admission_number': admissionNumber,
      'national_id': nationalId,
      'gender': gender,
      'address': address,
      'email': email,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'campus': campus,
      'profile_url': profileUrl,
      'password': password,
      'active': active,
      'vibe_points': vibePoints,
      'point_transactions': pointTransactions,
      'date_created': dateCreated?.toIso8601String(),
      'date_updated': dateUpdated?.toIso8601String(),
    };
  }
}
