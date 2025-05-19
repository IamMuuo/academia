import 'package:academia/database/database.dart';
import 'package:academia/utils/network/network.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

final class AttendanceRemoteRepository with DioErrorHandler {
  final DioClient _client = DioClient();

  Future<Either<String, String>> markAttendance(
    AttendanceModelData record,
  ) async {
    try {
      var data = record.toJson();
      String year = DateTime.now().year.toString();
      String month = DateTime.now().month < 9
          ? "0${DateTime.now().month}"
          : DateTime.now().month.toString();
      String day = DateTime.now().day < 9
          ? "0${DateTime.now().day}"
          : DateTime.now().day.toString();
      data["date"] = "$year-$month-$day";
      final response = await _client.dio.post(
        "/chapel/attendance/mark",
        data: data,
      );

      if (response.statusCode == 200) {
        return right(response.data["message"]);
      }

      print(response);

      return left(
        // response.data["message"] ??
            response.data["error"] ?? "Darn"
            // response.statusMessage,
      );
    } on DioException catch (de) {
      return handleDioError(de);
    } catch (e) {
      return left("Something went terribly wrong please retry that action");
    }
  }
}
