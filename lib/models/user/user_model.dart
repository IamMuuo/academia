// The user model
/// Represents a user's model as well as provides
/// JSON to and fro serialization functionality
class User {
  String? regno;
  String? name;
  String? idno;
  String? gender;
  String? address;
  String? email;
  String? dateOfBirth;
  String? campus;
  String? profile;
  String? password;

  User({
    this.regno,
    this.name,
    this.idno,
    this.gender,
    this.address,
    this.email,
    this.dateOfBirth,
    this.campus,
    this.profile,
    this.password,
  });

  /// Parses the [json] paramerter
  /// and returns a user model corresponsing to the data provided
  factory User.fromJson(Map<String, dynamic> json) => User(
        regno: json['regno'],
        name: json['name'],
        idno: json['idno'],
        gender: json['gender'],
        address: json['address'],
        email: json['email'],
        dateOfBirth: json['dateofbirth'],
        campus: json['campus'],
        profile: json['profile'],
        password: json["password"],
      );

  /// Serializes a user object to a map that
  /// can easily be converted to JSON
  Map<String, dynamic> toJson() => {
        'regno': regno,
        'name': name,
        'idno': idno,
        'gender': gender,
        'address': address,
        'email': email,
        'dateofbirth': dateOfBirth,
        'campus': campus,
        'profile': profile,
        'password': password,
      };

  /// Returns a map with th username and password
  /// for portal logins
  Map<String, String> loginJson() => {
        "username": regno!,
        "password": password!,
      };
}
