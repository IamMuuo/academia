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
  Artboard? _artboard;
  SMITrigger? loginFail, loginSuccess;
  SMIBool? isFocus, isPassword;
  SMINumber? eyeTrack;
  StateMachineController? stateMachineController;

  @override
  void initState() {
    super.initState();
    rootBundle.load("assets/rive/bunny_login.riv").then((value) {
      final file = RiveFile.import(value);
      _artboard = file.mainArtboard;
      stateMachineController =
          StateMachineController.fromArtboard(_artboard!, "State Machine 1");

      if (stateMachineController != null) {
        _artboard?.addController(stateMachineController!);
        for (final element in stateMachineController!.inputs) {
          if (element.name == "isFocus") {
            isFocus = element as SMIBool;
          } else if (element.name == "IsPassword") {
            isPassword = element as SMIBool;
          } else if (element.name == "login_success") {
            loginSuccess = element as SMITrigger;
          } else if (element.name == "login_fail") {
            loginFail = element as SMITrigger;
          } else if (element.name == "eye_track") {
            eyeTrack = element as SMINumber;
          }
        }
        setState(() {});
      }
    });
  }

  void _loginSuccess() {
    loginSuccess?.fire();
    setState(() {});
    isFocus?.change(true);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/icons/academia.png"),
          ),
        ),
        title: const Text("Academia"),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,
            children: [
              CircleAvatar(
                radius: 120,
                child: _artboard == null
                    ? null
                    : Rive(
                        artboard: _artboard!,
                      ),
              ),
              Text(
                "Welcome to Academia!",
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              Text(
                "Academia is for students by students - Truly open source 🔥",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                  minWidth: 240,
                ),
                child: TextFormField(
                  onTap: () {
                    isFocus!.change(true);
                  },
                  textAlign: TextAlign.center,
                  maxLength: 7,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    AdmnoDashFormatter(),
                  ],
                  decoration: InputDecoration(
                    hintText: "Your school admission number",
                    label: const Text("Admission number"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: 500,
                  minWidth: 240,
                ),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  obscureText: !_showPassword,
                  onTap: () {
                    isPassword!.change(true);
                    setState(() {});
                  },
                  onTapOutside: (v) {
                    isPassword!.change(false);
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        icon: Icon(!_showPassword
                            ? Bootstrap.eye
                            : Bootstrap.eye_slash)),
                    hintText: "Your school portal password",
                    label: const Text("School Password"),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              // Input buttons

              Container(
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12,
                  children: [
                    FilledButton(
                      onPressed: () {
                        _loginSuccess();
                      },
                      child: const Text("Login"),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Don't have account?"),
                    ),
                  ],
                ),
              ),

              // Terms of service and privacy policy
              Text.rich(
                TextSpan(
                  text: "By continuing you agree to our ",
                  children: [
                    TextSpan(
                      text: "Terms of service",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                    const TextSpan(text: " and "),
                    TextSpan(
                      text: "Privacy policy",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
