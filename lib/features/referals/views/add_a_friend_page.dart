import 'package:academia/features/auth/auth.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/referals/bloc/referral_cubit.dart';
import 'package:academia/utils/validator/validator.dart';
import 'package:dartz/dartz.dart' as drift;
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
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                _isLoading
                    ? Lottie.asset(
                        "assets/lotties/fetching.json",
                        height: 32,
                      )
                    : FilledButton(
                        onPressed: () async {
                          final userResponse = await context
                              .read<ReferralCubit>()
                              .fetchUserDetailsFromMagnet(
                                _admissionController.text.trim(),
                                _passwordController.text.trim(),
                              );

                          if (userResponse.isLeft()) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text((userResponse as drift.Left).value)));
                            return;
                          }

                          if (!context.mounted) return;
                          context.pushNamed(
                            "confirm-friends-details",
                            extra: (userResponse as drift.Right).value,
                          );
                        },
                        child: Text("Add an iSoul 🍎"),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
