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
    final AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
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
                    "Welcome to Academia! A space for students by students ❤️‍🔥",
                    style: Theme.of(context).textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  authCubit.state is AuthInitialState ||
                          authCubit.state is AuthLoadingState
                      ? const CircularProgressIndicator.adaptive()
                      : SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: () {
                              context.pushReplacementNamed(
                                AcademiaRouter.auth,
                              );
                            },
                            child: const Text("Get Started"),
                          ),
                        ),
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
