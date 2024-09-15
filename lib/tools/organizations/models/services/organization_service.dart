import 'package:academia/exports/barrel.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

class OrganizationService with ChirpService {
  Future<Either<String, List<Organization>>> fetchOrganizations(
      Map<String, String> authHeaders) async {
    try {
      // fetch organizations
      final response = await http.get(
        Uri.parse("${ChirpService.urlPrefix}/organizations/all"),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> rawOrganizations =
            json.decode(response.body).cast<Map<String, dynamic>>();

        return Right(
          rawOrganizations.map((e) => Organization.fromJson(e)).toList(),
        );
      }

      return const Left(
        "Something went wrong white attempting to fetch organizations",
      );
    } catch (e) {
      return const Left(
        "Please check your internet connection and try that again",
      );
    }
  }

  Future<Either<String, List<Membership>>> fetchUserMemberships(
      String userID, Map<String, String> authHeaders) async {
    try {
      // fetch organizations
      final response = await http.get(
        Uri.parse("${ChirpService.urlPrefix}/organizations/user/$userID"),
        headers: authHeaders,
      );

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> rawMemberships =
            json.decode(response.body).cast<Map<String, dynamic>>();

        return Right(
          rawMemberships.map((e) => Membership.fromJson(e)).toList(),
        );
      }

      return const Left(
        "Something went wrong white attempting to fetch organizations",
      );
    } catch (e) {
      return const Left(
        "Please check your internet connection and try that again",
      );
    }
  }
}
