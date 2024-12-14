import 'package:academia/features/auth/cubit/auth_cubit.dart';
import 'package:academia/features/auth/cubit/auth_states.dart';
import 'package:academia/utils/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            pinned: true,
            snap: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Academia"),
              centerTitle: true,
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverStack(
              positionedAlignment: Alignment.center,
              children: [
                SliverPositioned(
                  top: 0,
                  child: SliverPinnedHeader(
                    child: CircleAvatar(
                      radius: 120,
                      child: SvgPicture.asset("assets/images/studying.svg"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverFillRemaining(
              hasScrollBody: true,
              child: Column(
                children: [
                  const Spacer(),
                  Text(
                    "Welcome to Academia! A platform for students by students 🔥",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                    return state is AuthInitialState ||
                            state is AuthLoadingState
                        ? const CircularProgressIndicator.adaptive()
                        : SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () {
                                GoRouter.of(context).pushNamed(
                                  AcademiaRouter.auth,
                                );
                              },
                              child: const Text("Get Started"),
                            ),
                          );
                  }),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
