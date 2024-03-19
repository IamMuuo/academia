import 'package:academia/exports/barrel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
              FlutterCarousel(
                items: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset('assets/images/bot_hello.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset('assets/images/bot_wave.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Image.asset('assets/images/bot_love.png'),
                  ),
                ],
                options: CarouselOptions(
                  // height: MediaQuery.of(context).size.height * 0.5,
                  reverse: false,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  slideIndicator: CircularSlideIndicator(
                    indicatorBackgroundColor:
                        Theme.of(context).colorScheme.secondary,
                    indicatorRadius: 7,
                  ),
                ),
              ),

              // Welcoming message
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  "Your school life assistant awaits",
                  textAlign: TextAlign.center,
                  style: h1,
                ),
              ),

              // subtitle
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Academia is for you by you',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.off(
            const LoginPage(),
            duration: const Duration(seconds: 3),
            transition: Transition.fade,
          );
        },
        tooltip: "Get Started",
        child: const Icon(CupertinoIcons.arrow_right),
      ),
    );
  }
}
