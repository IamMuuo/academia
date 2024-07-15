import 'package:academia/models/core/user/user.dart';
import 'package:dartz/dartz.dart';

import '../models/models.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class StoryController extends GetxController {
  final StoryService _service = StoryService();
  RxMap<Organization, List<Story>> stories = <Organization, List<Story>>{}.obs;

  @override
  void onInit() {
    super.onInit();

    loadStories().then((value) => null);
    fetchAllOrganizations();
    fetchStories();
  }

  /// Fetches all organizations from the api and persists them to
  /// local storage also appends the data into the stories map
  Future<Either<String, List<Organization>>> fetchAllOrganizations() async {
    final result = await _service.fetchAllOrganizations();
    return result.fold((l) {
      return left(l);
    }, (r) {
      for (final org in r) {
        OrganizationModelHelper().create(
          org.toJson(),
        ); // Ok since the db will replace in event of conflict
        stories.putIfAbsent(org, () => List.empty(growable: true));
      }
      return right(r);
    });
  }

  Future<Either<String, List<Story>>> fetchStories() async {
    final result = await _service.fetchDueStories();
    return result.fold((l) {
      return left(l);
    }, (r) {
      for (final story in r) {
        StoryModelHelper().create(story.toJson());
        final storyOrg = story.organizationId;
        stories[stories.keys.where((element) => element.id == storyOrg).first]
            ?.add(story);
      }
      return right(r);
    });
  }

  Future<void> viewStory(Story s) async {
    s.viewed = true;
    await StoryModelHelper().create(s.toJson());

    if (s.dateOfExpiry.isAfter(DateTime.now())) {
      final storyOrg = s.organizationId;
      stories[stories.keys.where((element) => element.id == storyOrg)]
          ?.remove(s);
      await UserModelHelper().delete(s.toJson());
      debugPrint("Story successfully deleted");
    }
  }

  Future<void> loadStories() async {
    final organizations = await OrganizationModelHelper().queryAll();
    organizations.map((e) => stories.putIfAbsent(
        Organization.fromJson(e), () => List.empty(growable: true)));

    final rawStories = await StoryModelHelper().queryAll();

    rawStories.map((e) {
      final story = Story.fromJson(e);
      if (story.dateOfExpiry.isAfter(DateTime.now())) {
        StoryModelHelper().delete(story.toJson());
      } else {
        final storyOrg = story.organizationId;
        stories[stories.keys.where((element) => element.id == storyOrg).first]
            ?.add(story);
      }
    });
  }
}
