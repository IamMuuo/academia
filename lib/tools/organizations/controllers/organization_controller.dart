import 'package:academia/exports/barrel.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrganizationController extends GetxController {
  // For sending requests
  final OrganizationService _organizationService = OrganizationService();
  final StoryService _storyService = StoryService();
  final RxMap<Organization, List<Story>> stories =
      RxMap<Organization, List<Story>>();
  RxList<Organization> organizations = RxList<Organization>();

  late SharedPreferences prefs;

  @override
  void onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();

    final rawStoredOrganizations = prefs.getString("organizations");

    if (rawStoredOrganizations != null) {
      organizations.value = _decodeOrganizations(rawStoredOrganizations);

      for (final org in organizations) {
        stories[org] = List.empty(growable: true);
      }
      return;
    }
  }

  String _encodeOrganizatons(List<Organization> organizations) {
    List<Map<String, dynamic>> jsonList =
        organizations.map((org) => org.toJson()).toList();
    return jsonEncode(jsonList);
  }

  List<Organization> _decodeOrganizations(String rawOrganizations) {
    final List<dynamic> raw = jsonDecode(rawOrganizations);

    return raw.map((e) {
      return Organization.fromJson(e as Map<String, dynamic>);
    }).toList();
  }

  Future<bool> fetchStories(Map<String, String> authCreds) async {
    final result = await _storyService.fetchStories(authCreds);

    return result.fold((l) {
      return false;
    }, (r) {
      for (final story in r) {
        // print(story);
        final orgwithStory = stories.entries
            .firstWhere((elem) => elem.key.id == story.keys.first)
            .key;
        stories[orgwithStory] = story.values.first;
      }
      return true;
    });
  }

  Future<Either<String, List<Organization>>> fetchOrganizations(
      Map<String, String> authCreds) async {
    final result = await _organizationService.fetchOrganizations(authCreds);
    return result.fold((l) {
      return left(l);
    }, (r) async {
      prefs.setString(
        "organizations",
        _encodeOrganizatons(r),
      );

      organizations.value = r;

      return right(r);
    });
  }
}
