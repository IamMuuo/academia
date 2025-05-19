import 'package:academia/features/auth/auth.dart';
import 'package:academia/utils/validator/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:sliver_tools/sliver_tools.dart';

class AddAFriendPage extends StatefulWidget {
  const AddAFriendPage({super.key});

  @override
  State<AddAFriendPage> createState() => _AddAFriendPageState();
}

class _AddAFriendPageState extends State<AddAFriendPage> {
  final TextEditingController _admissionController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
            return;
          }
          if (state is NewAuthUserDetailsFetched) {
            context.pushNamed("confirm-friends-details");
            return;
          }
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              snap: true,
              pinned: true,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                title: Text("Lend an Android, Save an iSoul."),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.all(12),
              sliver: MultiSliver(
                children: [
                  Text(
                    "Android users, Assemble! 🚀 Our iOS comrades are temporarily stuck in the App Store void. For a limited time, be their heroes! iOS users are eager to experience our awesome ecosystem, help them get a sneak peek of essential features through your account. Let's show them how the open side lives! 😉 . Add them to our ecosystem by filling their details into the form below",
                  ),

                  SizedBox(height: 22),
                  // admission number input
                  TextFormField(
                    controller: _admissionController,
                    textAlign: TextAlign.center,
                    maxLength: 7,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      AdmnoDashFormatter(),
                    ],
                    validator: (value) {
                      if (value?.length != 7) {
                        return "Please provide a valid admission number😡";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    decoration: InputDecoration(
                      hintText: "Their school admission number",
                      label: const Text("Admission number"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: _showPassword,
                    textAlign: TextAlign.center,
                    validator: (value) {
                      if ((value?.length ?? 0) < 3) {
                        return "Please provide a valid password 😡";
                      }
                      return null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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

                  SizedBox(
                    height: 18,
                  ),

                  BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                    if (state is AuthLoadingState) {
                      return Lottie.asset(
                        "assets/lotties/fetching.json",
                        height: 80,
                      );
                    }
                    return FilledButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              RegistrationEventRequested(
                                admno: _admissionController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                      },
                      child: Text("Add an iSoul 🍎"),
                    );
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
