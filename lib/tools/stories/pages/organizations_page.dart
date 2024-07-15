import 'package:academia/tools/stories/pages/organization_page.dart';
import 'package:flutter/material.dart';
import '../stories.dart';
import 'package:get/get.dart';

class OrganizationsPage extends StatelessWidget {
  const OrganizationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final storyController = Get.find<StoryController>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text("Organizations"),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(8),
              color: Theme.of(context).colorScheme.tertiaryContainer,
              child: Text(
                "Organizations play a key role in your student life, find more info by tapping them",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          ),
          Obx(
            () => SliverList.separated(
              itemBuilder: (context, index) {
                final organization =
                    storyController.stories.keys.elementAt(index);
                final stories = storyController.stories[organization];
                return ListTile(
                  leading: OrganizationProfilePicture(
                    stories: stories!,
                    organization: organization,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OrganizationPage(
                            organization: organization, stories: stories),
                      ),
                    );
                  },
                  minVerticalPadding: 0,
                  contentPadding: EdgeInsets.zero,
                  title: Text(organization.name),
                  subtitle: Text(organization.email),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 8,
                child: Divider(),
              ),
              itemCount: storyController.stories.keys.length,
            ),
          ),
        ],
      ),
    );
  }
}
