import 'package:academia/exports/barrel.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final userController = Get.find<UserController>();
  TextEditingController admnoEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  // Loadind state
  bool _isLoading = false;
  bool _hidePassword = true;
  bool _acceptTerms = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // image
                Image.asset(
                  'assets/images/bot_search.png',
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                // Welcome  text
                Text(
                  'Welcome',
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 1, bottom: 20),
                  child: Text(
                    'Lets find you and setup things for you',
                    style: normal.copyWith(fontSize: 12),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    controller: admnoEditingController,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      AdmissionNumberFormatter(),
                    ],
                    validator: (value) {
                      if ((value?.length ?? 0) != 7) {
                        return "Please enter your admission numer ${Emojis.smile_angry_face}";
                      }

                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: 'xx-xxxx',
                      label: const Text("Your admission number"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextFormField(
                    controller: passwordEditingController,
                    obscureText: _hidePassword,
                    validator: (value) {
                      if ((value?.length ?? 0) <= 3) {
                        return "Please enter a valid password ${Emojis.smile_angry_face}";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Your school portal password',
                      label: const Text("Your password"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _hidePassword = !_hidePassword;
                          });
                        },
                        icon: Icon(
                          _hidePassword
                              ? Ionicons.eye_outline
                              : Ionicons.eye_off_outline,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                _isLoading
                    ? LoadingAnimationWidget.threeArchedCircle(
                        color: Theme.of(context).colorScheme.primary,
                        size: 40,
                      )
                    : FilledButton.icon(
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Form Validation error"),
                                content: const Text(
                                  "Please ensure the fields are well filled to continue",
                                ),
                                actions: [
                                  FilledButton.tonal(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Try again"),
                                  ),
                                ],
                              ),
                            );
                            return;
                          }

                          if (!_acceptTerms) {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Terms of Service"),
                                    content: const Text(
                                      "To continue you must agree to our terms and conditions of service",
                                    ),
                                    actions: [
                                      FilledButton(
                                        onPressed: () {
                                          _acceptTerms = true;
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("I agree"),
                                      ),
                                      FilledButton.tonal(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                    ],
                                  );
                                });
                          }
                          // send request
                          setState(() {
                            _isLoading = true;
                          });

                          try {
                            final auth = await userController.login(
                              admnoEditingController.text,
                              passwordEditingController.text.trim(),
                            );
                            if (!auth) {
                              throw ("Please check your admission number and password");
                            }
                            await userController.getUserDetails(
                                admnoEditingController.text.trim(),
                                passwordEditingController.text.trim());
                          } catch (e) {
                            if (mounted) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Error"),
                                      content: Text(e.toString()),
                                    );
                                  });
                            }
                            debugPrint(e.toString());
                          }

                          // route to dashboard
                          setState(() {
                            _isLoading = false;
                          });
                        },
                        icon: const Icon(Ionicons.log_in),
                        label: const Text("Get Started"),
                      ),
              ],
            ),
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
