import 'package:academia/exports/barrel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
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
              const Text('Welcome', textAlign: TextAlign.left, style: h2),
              Padding(
                padding: const EdgeInsets.only(top: 1, bottom: 20),
                child: Text('Lets find you and setup things for you',
                    style: normal.copyWith(fontSize: 12)),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: loginController.usernameController,
                  textAlign: TextAlign.center,
                  inputFormatters: [AdmissionNumberFormatter()],
                  decoration: const InputDecoration(
                    hintText: 'Your admission number',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Obx(
                  () => TextField(
                    controller: loginController.passwordController,
                    obscureText: loginController.showPassword.value,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      hintText: 'Your password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          loginController.showPassword.value =
                              !loginController.showPassword.value;
                        },
                        icon: const Icon(CupertinoIcons.eye),
                      ),
                    ),
                  ),
                ),
              ),

              // terms and conditions
              Padding(
                padding: const EdgeInsets.only(bottom: 30, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Checkbox(
                        value: loginController.acceptTerms.value,
                        onChanged: (value) {
                          loginController.acceptTerms.value = value!;
                        },
                      ),
                    ),
                    const Text(
                      'I agree to the terms and conditions',
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ],
                ),
              ),

              Obx(
                () => !loginController.isloading.value
                    ? ElevatedButton(
                        onPressed: () async {
                          await loginController.login();
                        },
                        child: const Text(
                          'Get started',
                          style: h6,
                        ),
                      )
                    : Center(
                        child: LoadingAnimationWidget.threeArchedCircle(
                          color: Theme.of(context).colorScheme.tertiary,
                          size: 30,
                        ),
                      ),
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
