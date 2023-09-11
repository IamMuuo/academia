import 'package:hive/hive.dart';
import 'package:get/get.dart';
import "package:academia/constants/common.dart";
import 'package:http/http.dart';
import "dart:convert";
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @HiveField(4)
  String? idno;

  @HiveField(5)
  String? gender;

  @HiveField(6)
  String? address;

  @HiveField(7)
  String? email;

  @HiveField(8)
  String? dateOfBirth;

  @HiveField(9)
  String? campus;

  @HiveField(10)
  String? programme;

  @HiveField(11)
  String? completedUnits;

  @HiveField(12)
  String? status;

  @HiveField(13)
  String? amountBilled;

  @HiveField(14)
  String? amountPaid;

  @HiveField(15)
  String? balance;

  @HiveField(16)
  String? cookie;

  @HiveField(17)
  String? profile;

  // To json object
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'admno': admno,
      'password': password,
      'gpa': gpa,
      'idno': idno,
      'gender': gender,
      'address': address,
      'email': email,
      'dateOfBirth': dateOfBirth,
      'campus': campus,
      'programme': programme,
      'completedUnits': completedUnits,
      'status': status,
      'amountBilled': amountBilled,
      'amountPaid': amountPaid,
      'balance': balance,
      'cookie': cookie,
      'profile': profile,
    };
  }

  // from json
  User.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'],
        gpa = json['gpa'],
        password = json['password'],
        admno = json['admno'],
        gender = json['gender'],
        address = json['address'],
        email = json['email'],
        dateOfBirth = json["dateOfBirth"],
        campus = json["campus"],
        programme = json["programme"],
        completedUnits = json["completedUnits"],
        status = json["status"],
        amountBilled = json["amountBilled"],
        amountPaid = json["amountPaid"],
        balance = json["balance"],
        cookie = json["cookie"],
        profile = json["profile"];

  Map<String, dynamic> toModel() {
    return {
      'username': admno,
      'password': password,
    };
  }

  User(); // Explicitly does nothing to silence warnings

  // Login a user
  Future<bool> login(String username, String password) async {
    // Make API request to authenticate user
    try {
      final url = Uri.parse("$urlPrefix/login");
      debugPrint(url.toString());
      final headers = {"Content-type": "application/json"};

      // Send a request
      final response = await post(
        url,
        headers: headers,
        body: json.encode({"username": username, "password": password}),
      );

      debugPrint("Login status code: ${response.statusCode}");
      debugPrint("Login cookie: ${response.headers['set-cookie']}");

      // Check response status
      if (response.statusCode == 200) {
        // Authentication successful
        cookie = response.headers['set-cookie'];
        return true;
      }
    } catch (error) {
      // Handle network or API errors
      debugPrint("Error during login: ${error.toString()}");
    }
    return false;
  }

  // Retrieves user details from the api
  Future<void> getUserDetails(String username, String password) async {
    try {
      final url = Uri.parse("$urlPrefix/api/user/");
      // final headers = {"Content-type": "application/json"};

      debugPrint("Attempting to get user details: $cookie");

      final response = await get(
        url,
        headers: {'cookie': cookie!},
      );

      debugPrint("Get user details status: ${response.statusCode}");

      // Check response status
      if (response.statusCode == 200) {
        dynamic jsonData = json.decode(response.body);

        // The values
        admno = jsonData[1]["badge"];
        name = jsonData[2]["badge"];
        idno = jsonData[3]["badge"];
        gender = jsonData[4]["badge"];
        address = jsonData[5]["badge"];
        email = jsonData[6]["badge"];
        dateOfBirth = jsonData[7]["badge"];
        campus = jsonData[8]["badge"];
        programme = jsonData[9]["badge"];
        completedUnits = jsonData[10]["badge"];
        gpa = double.parse(jsonData[11]["badge"]);
        status = jsonData[12]["badge"];
        amountBilled = jsonData[13]["badge"];
        amountPaid = jsonData[14]["badge"];
        balance = jsonData[15]["badge"];

        debugPrint("Success getting student data!");
      } else {
        debugPrint("Error getting user info");
        Get.snackbar(
          "Server Error",
          "There was an error trying to retrieve your details",
          icon: const Icon(
            CupertinoIcons.xmark_circle,
            color: Colors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
    }
  }
}
