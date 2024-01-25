import 'package:academia/constants/common.dart';
import 'package:academia/controllers/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Colors.white,
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
                          color: Theme.of(context).primaryColor,
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
