import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  String? name;

  @HiveField(1, defaultValue: 0.0)
  double? gpa;

  @HiveField(2)
  String? admno;

  @HiveField(3)
  String? password;

  // To json object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'admno': admno,
      'password': password,
      'gpa': gpa,
    };
  }

  // from json
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        gpa = json['gpa'],
        password = json['password'],
        admno = json['admno'];

  Map<String, dynamic> toModel() {
    return {
      'username': admno,
      'password': password,
    };
  }

  User(); // Explicitly does nothing to silence warnings
}
