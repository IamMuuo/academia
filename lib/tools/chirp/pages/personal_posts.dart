import 'package:academia/exports/barrel.dart';
import 'package:academia/tools/chirp/widgets/widgets.dart';
import 'package:dartz/dartz.dart' as dartz;
import '../controllers/chirp_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class PersonalPostsPage extends StatefulWidget {
  const PersonalPostsPage({super.key});

  @override
  State<PersonalPostsPage> createState() => _PersonalPostsPageState();
}

class _PersonalPostsPageState extends State<PersonalPostsPage>
    with AutomaticKeepAliveClientMixin {
  late Future<dartz.Either<String, List<Post>>> posts;
  @override
  bool get wantKeepAlive => true;

  final controller = Get.find<ChirpController>();
  @override
  void initState() {
    super.initState();
    posts = controller.fetchUserPosts();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        posts = controller.fetchUserPosts();
        setState(() {});
      },
      child: FutureBuilder(
        future: posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return const EmptyPostCard();
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 4,
                    ),
                itemCount: 12);
          }
          return snapshot.data!.fold((l) {
            return Center(
              child: Text("Snap! $l"),
            );
          }, (r) {
            if (r.isEmpty) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Lottie.asset(
                      "assets/lotties/empty.json",
                      height: 250,
                    ),
                    const SizedBox(height: 22),
                    Text(
                      "You have no posts, create a post to get started",
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
                itemBuilder: (context, index) {
                  final post = r[index];
                  return PostCard(post: post);
                },
                separatorBuilder: (context, index) => const SizedBox(height: 2),
                itemCount: r.length);
          });
        },
      ),
    );
  }
}
