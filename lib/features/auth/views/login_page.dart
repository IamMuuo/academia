import 'package:academia/utils/router/router.dart';
import 'package:academia/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sliver_tools/sliver_tools.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            floating: true,
            snap: true,
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/icons/academia.png",
                    ),
                    const Text("Academia"),
                  ],
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverPinnedHeader(
              child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        "Sign in",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          GoRouter.of(context)
                              .pushNamed(AcademiaRouter.registerRoute);
                        },
                        icon: const Icon(Bootstrap.question_circle),
                      ),
                    ],
                  ),

                  const Text(
                    "Use your school admission number and school portal password to continue to Academia.",
                  ),

                  TextFormField(
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

                  TextFormField(
                    obscureText: _showPassword,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: Icon(_showPassword
                              ? Bootstrap.eye
                              : Bootstrap.eye_slash)),
                      hintText: "Your school portal password",
                      label: const Text("School Password"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),

                  // Input buttons

                  FilledButton(
                    onPressed: () {},
                    child: const Text("Login"),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverFillRemaining(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("Privacy and terms of service"),
                  ),
                  const SizedBox(height: 12)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
