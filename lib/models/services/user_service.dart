import 'package:academia/exports/barrel.dart';
import 'package:academia/models/services/services.dart';
import 'package:academia/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';

class UserService with VerisafeService {
  String token = "";

  Map<String, String> getTokenHeaders() {
    return {"Token": token};
  }

  Future<Either<String, bool>> isStudentRegistered(String admission) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${VerisafeService.urlPrefix}/students/registered/$admission"),
      );

      if (response.statusCode == 200) {
        return right(true);
      }

      return const Left(
        "Student record does not exist!",
      );
    } catch (e) {
      if (e is http.ClientException) {
        return const Left(
            "Error communicating to server please check your network and try again later");
      }
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> deleteStudent(
      Map<String, String> authheaders, String userID) async {
    try {
      final response = await http.delete(
        Uri.parse("${VerisafeService.urlPrefix}/students/delete/$userID"),
        headers: authheaders,
      );

      if (response.statusCode == 200) {
        return right(true);
      }

      return const Left(
        "We ran into an error please retry again later!",
      );
    } catch (e) {
      if (e is http.ClientException) {
        return const Left(
            "Error communicating to server please check your network and try again later");
      }
      return Left(e.toString());
    }
  }

  /// Register
  /// Registers a user to verisafe
  Future<Either<String, User>> register(Map<String, dynamic> data) async {
    try {
      final response = await http.post(
        Uri.parse("${VerisafeService.urlPrefix}/students/register/"),
        body: json.encode(data),
      );

      if (response.statusCode == 201) {
        return right(User.fromJson(json.decode(response.body)));
      }

      return left(json.decode(response.body)["error"]);
    } catch (e) {
      if (e is http.ClientException) {
        return const Left(
          "Error communicating to server please check your network and try again later",
        );
      }
      return Left(e.toString());
    }
  }

  /// Register
  /// Registers a user to verisafe
  Future<Either<String, User>> login(String admno, String password) async {
    try {
      final response = await http.post(
        Uri.parse("${VerisafeService.urlPrefix}/users/login/"),
        body: json.encode({
          "admission_number": admno,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        token = response.headers["token"]!;
        return right(User.fromJson(json.decode(response.body)));
      }

      return left(json.decode(response.body)["error"]);
    } catch (e) {
      if (e is http.ClientException) {
        return const Left(
          "Error communicating to server please check your network and try again later",
        );
      }
      return Left(e.toString());
    }
  }

  // Upload profile picture
  Future<Either<String, User>> uploadProfilePicture(
      String id, Uint8List imageFile, String filename) async {
    try {
      final request = http.MultipartRequest(
        "PATCH",
        Uri.parse("${VerisafeService.urlPrefix}/users/profile/upload/$id"),
      );

      request.headers.addAll({"Token": token});
      request.files.add(http.MultipartFile.fromBytes(
        "profile",
        imageFile,
        filename: filename,
      ));

      final response = await request.send();

      if (response.statusCode == 200) {
        return right(
          User.fromJson(json.decode(await response.stream.bytesToString())),
        );
      }

      return Left(json.decode(await response.stream.bytesToString())["error"]);
    } catch (e) {
      if (e is http.ClientException) {
        return const Left(
          "Error communicating to server please check your network and try again later",
        );
      }
      return Left(e.toString());
    }
  }
}
