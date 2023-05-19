import 'package:academia/models/user_utils.dart';
import 'package:academia/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _admnoController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _hiddenPasswordFlag = false;
  bool? _acceptedTerms = false;

  void _acceptedTermsHandler(bool? newValue) {
    setState(() {
      _acceptedTerms = newValue;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _admnoController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  controller: _admnoController,
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
                child: TextField(
                  controller: _passwordController,
                  obscureText: !_hiddenPasswordFlag,
                  decoration: InputDecoration(
                    hintText: 'Your password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _hiddenPasswordFlag = !_hiddenPasswordFlag;
                        });
                      },
                      icon: const Icon(CupertinoIcons.eye),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
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
                    Checkbox(
                      value: _acceptedTerms,
                      onChanged: _acceptedTermsHandler,
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

              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  );
                  try {
                    createUser(_admnoController.text, _passwordController.text);
                  } catch (e) {}
                  //Navigator.of(context).pop();
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
