import 'package:academia/models/services/services.dart';
import 'package:academia/models/models.dart';
import 'package:http/http.dart';
import 'package:dartz/dartz.dart';

class UserService with VerisafeService {
  Future<Either<Exception, User>> registerUser(
      Map<String, dynamic> data) async {}
}
