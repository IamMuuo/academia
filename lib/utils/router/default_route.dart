import 'package:academia/features/auth/cubit/auth_cubit.dart';
import 'package:academia/features/auth/cubit/auth_states.dart';
import 'package:academia/features/auth/views/widgets/user_selection_page.dart';
import 'package:academia/features/onboarding/views/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultRoute extends StatelessWidget {
  const DefaultRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case AuthErrorState:
            return Center(
              child: Text(
                (state as AuthErrorState).message,
              ),
            );
          case AuthCachedUsersRetrieved:
            return const UserSelectionPage();
        }
        return const OnboardingPage();
      },
    );
  }
}
