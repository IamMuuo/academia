import 'package:academia/exports/barrel.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final userController = Get.find<UserController>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController admnoEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  bool showUsernameField = false;
  bool hidePassword = true;
  bool isLoading = false;

  Future<void> login() async {
    final result = await userController.login(
      admnoEditingController.text,
      passwordEditingController.text,
    );

    result.fold(
      (l) {
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
      },
      (r) {
        HapticFeedback.heavyImpact().then((value) {
          if (userController.isLoggedIn.value) {
            if (!mounted) return;
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const LayoutPage(),
              ),
            );
            return;
          }
        });
        r["password"] = passwordEditingController.text;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RegisterPage(userData: r),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Text(
                "Lets find you and set up things for you",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Lottie.asset(
                "assets/lotties/search.json",
                height: 200,
              ),
              const SizedBox(height: 22),
              TextFormField(
                controller: admnoEditingController,
                maxLength: 7,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  AdmissionNumberFormatter(),
                ],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value?.length != 7) {
                    return "Please enter a valid admission number";
                  }
                  return null;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "xx-xxxx",
                  label: const Text("Admisson Number"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: passwordEditingController,
                obscureText: hidePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if ((value?.length ?? 0) <= 4) {
                    return "Please enter a valid password";
                  }
                  return null;
                },
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Your secret password",
                  label: const Text("Password"),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      icon: Icon(
                        hidePassword
                            ? Ionicons.lock_closed
                            : Ionicons.lock_open,
                      )),
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
                      onPressed: () async {
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

                        await login();

                        setState(() {
                          isLoading = false;
                        });
                      },
                      // onPressed: () {
                      //   Navigator.of(context).push(
                      //     MaterialPageRoute(
                      //       builder: (context) => const LayoutPage(),
                      //     ),
                      //   );
                      // },
                      icon: const Icon(Ionicons.lock_closed),
                      label: const Text("Login"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdmissionNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // final oldValueText = oldValue.text;
    final newValueText = newValue.text;

    if (newValueText == '') {
      return newValue;
    } else if (newValueText.length <= 2) {
      return newValue;
    } else if (newValueText.length == 3) {
      return newValueText.endsWith('-')
          ? newValue
          : TextEditingValue(
              text:
                  "${newValueText.substring(0, 2)}-${newValueText.substring(2)}",
            );
    } else if (newValueText.length <= 7) {
      return newValue;
    } else {
      return oldValue;
    }
  }
}
