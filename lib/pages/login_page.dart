import 'package:academia/controllers/login_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              Image.asset('assets/images/girl_holding_phone.png'),
              // Welcome  text
              const Text(
                'Welcome',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 1, bottom: 20),
                child: Text(
                  'Good things coming your way',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: loginController.usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Your admission number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
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
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
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
                      style: TextStyle(
                        // fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              Obx(
                () => !loginController.isloading.value
                    ? ElevatedButton(
                        onPressed: () {
                          loginController.login();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          minimumSize: const Size(327, 60),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                        ),
                        child: const Text(
                          'I want in',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
