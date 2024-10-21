import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../widgets/fees_card.dart';

class FeesPage extends StatelessWidget {
  const FeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController =
        Get.find<SettingsController>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              "Fees Statements",
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Ionicons.close_outline),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Information"),
                      content: const Text(
                        "Here you can view your fees statements - data is provided as is",
                      ),
                      actions: [
                        FilledButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Oh ok")),
                      ],
                    ),
                  );
                },
                icon: const Icon(Ionicons.information),
              )
            ],
          ),
          SliverFillRemaining(
            child: Obx(
              () => settingsController.settings.value.showFeeStatistics
                  ? FutureBuilder(
                      future: magnet.fetchFeeStatement(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset("assets/lotties/fetching.json"),
                              const SizedBox(height: 22),
                              Text(
                                "Loading fees statements, we are. Powerful, the Force flows.",
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          );
                        }

                        if (snapshot.hasError) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset("assets/lotties/error.json"),
                              const SizedBox(height: 22),
                              Text(
                                "Please try again if the problem persists try after an hour",
                                textAlign: TextAlign.center,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          );
                        }

                        return snapshot.data!.fold(
                          (l) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset("assets/lotties/error.json"),
                                const SizedBox(height: 22),
                                Text(
                                  "Lost, your records are. Found it, we could not.",
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ],
                            );
                          },
                          (r) {
                            r = r.reversed.toList();
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 4),
                                itemBuilder: (context, index) {
                                  final data = r[index];

                                  return FeesCard(
                                    data: data,
                                    index: index,
                                  );
                                },
                                itemCount: r.length,
                              ),
                            );
                          },
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/sketchbook-woman-and-a-man-analyze-data-2.png",
                          ),
                          const SizedBox(height: 22),
                          Text(
                            "You have disabled showing fee statistics from settings, please enable the feature to show your statistics here",
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
