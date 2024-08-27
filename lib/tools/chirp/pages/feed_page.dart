import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../widgets/widgets.dart';
import '../controllers/chirp_controller.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final ChirpController controller = Get.find<ChirpController>();
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Obx(
          () => controller.feedLoading.value || true
              ? ListView.builder(
                  itemBuilder: (context, index) => EmptyPostCard(),
                )
              : Text("Loaded"),
        ),
        onRefresh: () async {
          Future.delayed(Duration(seconds: 5));
        });
  }
}
// Obx(
//                () => controller.isLoading.value
//                    ? SingleChildScrollView(
//                        child: Column(
//                          children: [
//                            Lottie.asset("assets/lotties/fetching.json"),
//                            const SizedBox(height: 22),
//                            Text(
//                              "Fetching posts",
//                              textAlign: TextAlign.center,
//                              style: Theme.of(context).textTheme.headlineSmall,
//                            ),
//                          ],
//                        ),
//                      )
//                    : RefreshIndicator(
//                        onRefresh: () async {
//                          await controller.fetchPosts();
//                        },
//                        child: controller.posts.isEmpty
//                            ? SingleChildScrollView(
//                                child: Column(
//                                  children: [
//                                    Lottie.asset("assets/lotties/empty.json"),
//                                    Text(
//                                      "Argh snap! We couldn't find posts at the moment. Please try again later",
//                                      textAlign: TextAlign.center,
//                                      style: Theme.of(context)
//                                          .textTheme
//                                          .headlineSmall,
//                                    ),
//                                  ],
//                                ),
//                              )
//                            : ListView.separated(
//                                itemBuilder: (context, index) {
//                                  final data = controller.posts[index];
//                                  return PostCard(post: data);
//                                },
//                                separatorBuilder: (context, index) =>
//                                    const SizedBox(
//                                  height: 8,
//                                  child: Divider(thickness: 0.3),
//                                ),
//                                itemCount: controller.posts.length,
//                              ),
//                      ),
//              ),
//
