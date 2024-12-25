import 'package:academia/database/database.dart';
import 'package:academia/features/auth/cubit/auth_cubit.dart';
import 'package:academia/features/auth/cubit/auth_states.dart';
import 'package:academia/features/auth/views/widgets/user_selection_tile.dart';
import 'package:academia/utils/router/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sliver_tools/sliver_tools.dart';

class UserSelectionPage extends StatefulWidget {
  const UserSelectionPage({super.key});

  @override
  State<UserSelectionPage> createState() => _UserSelectionPageState();
}

class _UserSelectionPageState extends State<UserSelectionPage> {
  late AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

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
              child: Text(
                "Please select a user to continue",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),

          // Sliverlist

          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) {
              if (current is AuthCachedUsersRetrieved) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              final List<UserData> users =
                  (state as AuthCachedUsersRetrieved).cachedUsers;
              return SliverList.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return UserSelectionTile(
                    user: users[index],
                  );
                },
              );
            },
          ),
          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      context.pushNamed(AcademiaRouter.auth);
                    },
                    label: const Text("Add Account"),
                    icon: const Icon(Bootstrap.person_add),
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
