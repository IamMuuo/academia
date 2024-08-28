import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Welcome image ...
                Lottie.asset(
                  "assets/lotties/study.json",
                ),

                // Welcoming message
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    "School doesn't have to be boring anymore",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),

                // subtitle
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Academia is for students by students ${Emojis.game_heart_suit}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FutureBuilder(
            future: Future.delayed(
              const Duration(seconds: 3),
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return FloatingActionButton(
                  onPressed: () {
                    HapticFeedback.heavyImpact().then((value) => Get.off(
                          const LoginPage(),
                          duration: const Duration(seconds: 3),
                          transition: Transition.fade,
                        ));
                  },
                  tooltip: "Get Started",
                  child: const Icon(Ionicons.arrow_forward),
                );
              }
              return const SizedBox();
            }));
  }
}
