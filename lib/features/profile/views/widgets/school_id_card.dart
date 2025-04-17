import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SchoolIdCard extends StatelessWidget {
  const SchoolIdCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (stateA, stateB) => (stateB is AuthenticatedState),
      builder: (context, state) => Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        elevation: 1,
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Row(
                children: [
                  Image.asset(
                    "assets/logos/du-logo.png",
                    width: 120,
                    height: 80,
                  ),
                  Spacer(),
                  Text(
                    "STUDENT",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: Colors.red,
                        ),
                  ),
                ],
              ),
              Text(
                "${(state as AuthenticatedState).user.firstname.toUpperCase()} ${(state).user.othernames?.toUpperCase()}",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Row(
                spacing: 12,
                children: [
                  Image.memory(
                    state.user.picture!,
                    width: 140,
                    errorBuilder: (context, obj, error) => CircleAvatar(
                      radius: 40,
                      child: Text(state.user.firstname[0]),
                    ),
                  ),
                  BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, profileState) {
                    final profile =
                        (profileState as ProfileLoadedState).profile;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 8,
                      children: [
                        Text.rich(
                          TextSpan(
                            text: "ID/Passport: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: state.user.nationalId,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Student No: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: profile.admissionNumber,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            text: "Nationality: ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                text: "unknown",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          profile.admissionNumber,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                fontFamily:
                                    GoogleFonts.libreBarcode39().fontFamily,
                              ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
              Text(
                "Note that this is a representation of the school id card and might not be acceptable everywhere",
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 9),
              )
            ],
          ),
        ),
      ),
    );
  }
}
