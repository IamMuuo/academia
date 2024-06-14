import 'package:academia/exports/barrel.dart';
import 'package:flutter/services.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Visibility(
                visible: showUsernameField,
                child: TextFormField(
                  controller: usernameController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Username cannot be changed once set",
                    label: const Text("Username"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: admnoEditingController,
                maxLength: 7,
                inputFormatters: [
                  AdmissionNumberFormatter(),
                ],
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
              FilledButton.icon(
                onPressed: () {},
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
