import 'dart:convert';
import 'package:academia/models/user.dart';
import 'package:http/http.dart';
import 'package:hive_flutter/hive_flutter.dart';

const urlPrefix = "https://backend.kimworks.buzz";

// Creates a user and directly stores them in a database
Future<void> createUser(String username, String password) async {
  final url = Uri.parse('$urlPrefix/login');
  final headers = {"Content-type": "application/json"};

  User newStudent = User()
    ..admno = username
    ..password = password;

  final response = await post(url,
      headers: headers, body: json.encode(newStudent.toModel()));

  if (response.statusCode != 200) {
    throw "No internet";
  }

  Box appDB = Hive.box('appDB');
  appDB.add(newStudent);

  var sessions = {
    "cookie": jsonDecode(response.body)["cookie"],
  };
  appDB.put("sessions", sessions);
}
