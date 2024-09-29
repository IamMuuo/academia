import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/chirp/pages/story_view_page.dart';
import 'package:get/get.dart';

class StoryHeader extends StatelessWidget {
  const StoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final OrganizationController organizationController =
        Get.find<OrganizationController>();
    final UserController userController = Get.find<UserController>();

    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: FutureBuilder(
          future:
              organizationController.fetchStories(userController.authHeaders),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => const CircleAvatar(radius: 35),
              );
            }

            return Obx(
              () => ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: organizationController.stories.keys.length,
                separatorBuilder: (context, index) => const SizedBox(width: 4),
                itemBuilder: (context, index) {
                  final data =
                      organizationController.stories.keys.elementAt(index);
                  return Visibility(
                    visible: organizationController.stories.values
                        .elementAt(index)
                        .isNotEmpty,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StoryViewPage(
                              organization: data,
                              stories: organizationController.stories.values
                                  .elementAt(index),
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Badge(
                            backgroundColor: Colors.blue,
                            label: Text(
                              organizationController.stories.values
                                  .elementAt(index)
                                  .length
                                  .toString(),
                            ),
                            child: CircleAvatar(
                              radius: 35,
                              backgroundImage:
                                  CachedNetworkImageProvider(data.logo!),
                            ),
                          ),
                          Text(
                            data.name,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
