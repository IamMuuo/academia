import 'package:academia/utils/validator/validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Login to Academia",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 100,
                child: RiveAnimation.asset(
                  "assets/rive/bunny_login.riv",
                ),
              ),
            ),
            const SizedBox(height: 22),
            TextFormField(
              textAlign: TextAlign.center,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d{0,2}-?\d{0,4}$'),
                ),
                AdmnoDashFormatter(),
              ],
              decoration: InputDecoration(
                label: const Text("Admission Number"),
                hintText: "00-0000",
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              textAlign: TextAlign.center,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                  icon: Icon(
                      _showPassword ? EvaIcons.eye_off_outline : EvaIcons.eye),
                ),
                label: const Text("Password"),
                hintText: "Provide your school portal password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const Spacer(),
            Text.rich(
              TextSpan(
                text: "By tapping login or signup you agree to our ",
                children: [
                  TextSpan(
                    text: "Terms of service",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy policy",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton.icon(
                  icon: const Icon(EvaIcons.flash_outline),
                  onPressed: () {},
                  label: const Text("Login"),
                ),
                const Text(" Or "),
                OutlinedButton(
                  onPressed: () {
                    HapticFeedback.heavyImpact();
                    GoRouter.of(context).push("/register");
                  },
                  child: const Text("Sign up"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
