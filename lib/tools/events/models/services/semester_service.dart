import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import '../models.dart';
import 'notifier_service.dart';

class SemesterService with NotifierService {
  Future<Either<String, List<Semester>>> fetchAllSemesters() async {
    try {
      final response =
          await http.get(Uri.parse("$notifierUrlPrefix/semesters/all"));

      if (response.statusCode == 200) {
        final body = json.decode(response.body).cast<Map<String, dynamic>>();
        return right(
            body.map((e) => Semester.fromJson(e)).toList().cast<Semester>());
      }

      return const Left("We are maintaining the server please try again later");
    } catch (e) {
      return const Left(
        "Error communicating to server please check your connection",
      );
    }
  }

  Future<Either<String, List<SemesterEvent>>> fetchSemesterEvent(
      String semester) async {
    try {
      final response = await http
          .get(Uri.parse("$notifierUrlPrefix/semesters/events/$semester"));

      if (response.statusCode == 200) {
        final body = json.decode(response.body).cast<Map<String, dynamic>>();
        return right(body
            .map((e) => SemesterEvent.fromJson(e))
            .toList()
            .cast<SemesterEvent>());
      }

      return const Left("We are maintaining the server please try again later");
    } catch (e) {
      return const Left(
        "Error communicating to server please check your connection",
      );
    }
  }

  Future<Either<String, Semester>> fetchCurrentSemester() async {
    try {
      final response =
          await http.get(Uri.parse("$notifierUrlPrefix/semesters/current"));

      if (response.statusCode == 200) {
        final List<Map<String, dynamic>> body = json.decode(response.body);
        return right(Semester.fromJson(body.first));
      }

      return const Left("We are maintaining the server please try again later");
    } catch (e) {
      return const Left(
        "Error communicating to server please check your connection",
      );
    }
  }
}
