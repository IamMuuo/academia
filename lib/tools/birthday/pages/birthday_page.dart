import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:academia/exports/barrel.dart';
import 'package:lottie/lottie.dart';

class BirthDayPage extends StatelessWidget {
  BirthDayPage({super.key});

  final UserController userController = Get.find<UserController>();
  int get years {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');

    var dob =
        inputFormat.parse(userController.user.value!.dateOfBirth.toString());
    return DateTime.now().year - dob.year;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton.outlined(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Ionicons.close),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: ProfilePictureWidget(
                profileSize: 80,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: Text(
                "Happy birthday ${userController.user.value!.firstName} ${Emojis.activites_confetti_ball}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Lottie.asset("assets/lotties/birthday.json"),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Text(
                """Academia wishes you a happy $years birthday!Remember you're one year older from your birth and one closer to your death\nWe celebrate you!""",
                textAlign: TextAlign.center,
              ),
            ),
          )
        ],
      ),
    );
  }
}
