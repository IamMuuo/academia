import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final coursesController = Get.find<CoursesController>();
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          floating: true,
          snap: true,
          pinned: true,
          title: const Text("Courses"),
          actions: [
            IconButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Courses"),
                    content: const Text(
                      "Here you can view your courses and everything in between",
                    ),
                    actions: [
                      FilledButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cool"),
                      )
                    ],
                  ),
                );
              },
              icon: const Icon(Ionicons.information_circle_outline),
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          sliver: SliverFillRemaining(
              child: RefreshIndicator(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset("assets/lotties/fetching.json"),
                Text(
                  "Fetching your courses",
                  style: Theme.of(context).textTheme.headlineLarge,
                )
              ],
            ),
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 5));
            },
          )),
        ),
      ],
    );
  }
}
