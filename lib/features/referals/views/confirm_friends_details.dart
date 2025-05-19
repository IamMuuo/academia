import 'dart:convert';

import 'package:academia/constants/common.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';
import 'package:academia/utils/router/router.dart';
import 'package:academia/utils/validator/validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ConfirmFriendsDetails extends StatefulWidget {
  const ConfirmFriendsDetails({super.key});

  @override
  State<ConfirmFriendsDetails> createState() => _ConfirmFriendsDetailsState();
}

enum _Gender { male, female }

class _ConfirmFriendsDetailsState extends State<ConfirmFriendsDetails> {
  final TextEditingController _admissionController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _fullNamesController = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nationalIDController = TextEditingController();
  final _formState = GlobalKey<FormState>();
  String password = '';
  bool accepted = false;
  DateTime? dob;
  Uint8List? imageBytes;

  // are required to complete the form

  _Gender gender = _Gender.male;

  @override
  void initState() {
    super.initState();
    loadInfo();
  }

  void loadInfo() {
    final state = BlocProvider.of<AuthBloc>(context).state;
    final details = (state as NewAuthUserDetailsFetched).userDetails;
    _fullNamesController.text = details["name"]!.title();
    _admissionController.text = details["regno"]!;
    _emailcontroller.text = details["email"]!;
    _addressController.text = details["address"]!;
    _nationalIDController.text = details['idno']!;
    dob = DateFormat("dd/MM/yyyy").parse(details['dateofbirth']!);
    gender = details['gender'] == 'male' ? _Gender.male : _Gender.female;
    password = details["password"]!;
    try {
      imageBytes = base64Decode(details['profile']!);
    } catch (e) {
      imageBytes = Uint8List(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
            return;
          }
          if (state is AuthenticatedState) {
            // GoRouter.of(context).clearStackAndNavigate("dashboard");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "Thank you for saving ${_fullNamesController.text.split(' ').first}",
                ),
              ),
            );

            return;
          }
        },
        child: Form(
          key: _formState,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                snap: true,
                expandedHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                  title: BlocBuilder<AuthBloc, AuthState>(
                      buildWhen: (stateA, stateB) {
                    if (stateB is NewAuthUserDetailsFetched) {
                      return true;
                    }
                    return false;
                  }, builder: (context, state) {
                    if (state is! NewAuthUserDetailsFetched) {
                      return Text(
                        "Hi there Anonymous",
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontFamily: GoogleFonts.lora().fontFamily,
                            ),
                      ).animate().moveY(
                          duration: 2000.ms,
                          begin: -10,
                          end: 0,
                          curve: Curves.easeInOut);
                    }
                    return Text(
                      "Hi there ${state.userDetails['name']?.split(' ').first.title()}!",
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontFamily: GoogleFonts.lora().fontFamily,
                              ),
                    ).animate().moveY(
                        duration: 2000.ms,
                        begin: -10,
                        end: 0,
                        curve: Curves.easeInOut);
                  }),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              "Please complete your profile to view more options"),
                        ),
                      );
                    },
                    icon: CircleAvatar(
                      radius: 18,
                      backgroundImage: MemoryImage(imageBytes ?? Uint8List(0)),
                    ),
                  ),
                ],
              ),
              BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
                return SliverPadding(
                  padding: EdgeInsets.all(12),
                  sliver: MultiSliver(
                    children: [
                      SliverPinnedHeader(
                        child: Container(
                          color: Theme.of(context).colorScheme.surface,
                          child: Row(
                            children: [
                              Lottie.asset(
                                "assets/lotties/bunny.json",
                                height: 160,
                              ),

                              // Headline
                              Flexible(
                                child: Text(
                                  "Please confirm your details.",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ).animate().moveX(
                                    begin: -10, end: 3, duration: 500.ms),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text("1"),
                          ),
                          title: Text("Identity"),
                          subtitle: Text("Manage your Identity details"),
                        ),
                      ),

                      SizedBox(height: 22),
                      // Form
                      TextFormField(
                        controller: _nationalIDController,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if ((value?.length ?? 0) < 8) {
                            return "Please provide a valid National Identification NUmber";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: "Your national ID number",
                          label: const Text("National Identification Number"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),

                      Wrap(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              enabled: false,
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
                                hintText: "Your school admission number",
                                label: const Text("Admission number"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: TextFormField(
                              controller: _usernameController,
                              textAlign: TextAlign.center,
                              validator: (value) {
                                RegExp regExp = RegExp(r'^[a-zA-Z0-9._]+$');

                                if (value == null || value.isEmpty) {
                                  return "Username cannot be empty";
                                } else if (!regExp.hasMatch(value)) {
                                  return "Only letters, numbers, dots, and underscores are allowed";
                                } else {
                                  return null; // Username is valid
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                hintText: "Your username",
                                label: const Text("Username"),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        controller: _fullNamesController,
                        enabled: false,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if ((value?.length ?? 0) < 10) {
                            return "Please provide your full name";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        decoration: InputDecoration(
                          hintText: "Your school admission number",
                          label: const Text("Your full names"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),

                      SizedBox(height: 16),
                      Card(
                        elevation: 0,
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text("3"),
                          ),
                          title: Text("Bio Data"),
                          subtitle: Text("Provide us with your bio-data"),
                        ),
                      ),
                      SizedBox(height: 8),

                      Text("When were you born?"),
                      SizedBox(height: 8),
                      ListTile(
                        leading: Icon(Icons.cake),
                        title: Text(DateFormat("dd/MM/yyyy").format(dob!)),
                      ),

                      SizedBox(height: 8),

                      Text("Select your gender"),
                      RadioListTile.adaptive(
                        title: Text("Male"),
                        value: _Gender.male,
                        groupValue: gender,
                        onChanged: (val) {
                          setState(() {
                            gender = val!;
                          });
                        },
                      ),
                      RadioListTile.adaptive(
                        title: Text("Female"),
                        value: _Gender.female,
                        groupValue: gender,
                        onChanged: (val) {
                          setState(() {
                            gender = val!;
                          });
                        },
                      ),

                      SizedBox(height: 16),

                      Card(
                        elevation: 0,
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text("3"),
                          ),
                          title: Text("Contacts"),
                          subtitle:
                              Text("Provide us with your contact information"),
                        ),
                      ),

                      SizedBox(height: 8),
                      TextFormField(
                        enabled: false,
                        controller: _emailcontroller,
                        textAlign: TextAlign.center,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          hintText: "Your Email Address",
                          label: const Text("Email Address"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),

                      SizedBox(height: 8),
                      TextFormField(
                        controller: _addressController,
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if ((value?.length ?? 0) < 2) {
                            return "Please provide a valid Address";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Your Address",
                          label: const Text("Address"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoadingState) {
                              return Lottie.asset(
                                "assets/lotties/loading-bounce.json",
                                height: 60,
                              );
                            }
                            return FilledButton(
                              onPressed: () {
                                if (!_formState.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                      "Please ensure you complete the form to continue",
                                    )),
                                  );
                                  return;
                                }

                                // split full names from the names
                                final nameparts =
                                    _fullNamesController.text.split(' ');

                                // perform signup
                                context.read<AuthBloc>().add(
                                      AddIsoulEvent(
                                        user: UserData(
                                            picture: imageBytes!,
                                            id: '',
                                            username:
                                                _usernameController.text.trim(),
                                            firstname: nameparts.first,
                                            othernames: nameparts.length > 1
                                                ? nameparts
                                                    .sublist(
                                                        nameparts.length - 2)
                                                    .join(' ')
                                                : nameparts.join(' '),
                                            email: _emailcontroller.text
                                                .toLowerCase()
                                                .trim(),
                                            gender: gender == _Gender.male
                                                ? "male"
                                                : "female",
                                            active: true,
                                            createdAt: DateTime.now(),
                                            modifiedAt: DateTime.now(),
                                            nationalId: _nationalIDController
                                                .text
                                                .trim()),
                                        profile: UserProfileData(
                                          userId: '',
                                          admissionNumber:
                                              _admissionController.text.trim(),
                                          vibePoints: 0,
                                          lastSeen: DateTime.now(),
                                          createdAt: DateTime.now(),
                                          modifiedAt: DateTime.now(),
                                          campus: 'athi',
                                          dateOfBirth: dob!,
                                        ),
                                        creds: UserCredentialData(
                                            admno: _admissionController.text,
                                            username: _usernameController.text,
                                            email: _emailcontroller.text,
                                            password: password),
                                      ),
                                    );
                              },
                              child: Text(
                                  "Add ${_fullNamesController.text.split(' ').first}"),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
