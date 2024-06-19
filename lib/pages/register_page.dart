import 'package:academia/exports/barrel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, required this.userData});
  final Map<String, dynamic> userData;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();

  final userController = Get.find<UserController>();
  final rewardsController = Get.find<RewardController>();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> register(Map<String, dynamic> data) async {
    data["username"] = usernameController.text;
    final result = await userController.register(data);
    result.fold((l) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(l),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Oh ok"),
            ),
          ],
        ),
      );
    }, (r) {
      if (r && userController.isLoggedIn.value) {
        HapticFeedback.heavyImpact().then((value) {
          rewardsController.awardPoints(10, "Newbie login");
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
        return;
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Snap"),
          content: const Text("Something went terribly wrong"),
          actions: [
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Oh ok"),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SafeArea(
          minimum: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                "Hi there ${widget.userData['name'].toString().split(" ")[0].title()}, just one more step",
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 22),
              TextFormField(
                controller: usernameController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if ((value?.length ?? 0) <= 4) {
                    return "Please try another cool nickname";
                  }
                  return null;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Clarification"),
                          content: const Text(
                            "Nicknames are a way to publically show your info without compromising your identity",
                          ),
                          actions: [
                            FilledButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Ooh wow"))
                          ],
                        ),
                      );
                    },
                    icon: const Icon(
                      Ionicons.information_circle,
                    ),
                  ),
                  hintText: "Please select your new nickname",
                  label: const Text("Nickname"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const Spacer(),
              isLoading
                  ? Lottie.asset(
                      "assets/lotties/loading.json",
                      height: 45,
                    )
                  : FilledButton.icon(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Error"),
                              content:
                                  const Text("Please ensure you fill the form"),
                              actions: [
                                FilledButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Oh ok"),
                                ),
                              ],
                            ),
                          );
                          return;
                        }

                        setState(() {
                          isLoading = true;
                        });
                        register(widget.userData).then((value) {});

                        setState(() {
                          isLoading = false;
                        });
                      },
                      icon: const Icon(Ionicons.flame_outline),
                      label: const Text("Let the fun begin"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
