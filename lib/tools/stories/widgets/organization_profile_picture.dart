import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../stories.dart';

class OrganizationProfilePicture extends StatelessWidget {
  const OrganizationProfilePicture({
    super.key,
    required this.organization,
    required this.stories,
    this.radius = 40,
  });
  final Organization organization;
  final List<Story> stories;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => StoryViewPage(
              organization: organization,
              stories: stories,
            ),
          ),
        );
      },
      child: CircleAvatar(
        radius: radius,
        backgroundImage: CachedNetworkImageProvider(organization.profile),
      ),
    );
  }
}
