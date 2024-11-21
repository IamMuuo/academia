import 'package:academia/database/database.dart';
import 'package:academia/features/auth/cubit/auth_cubit.dart';
import 'package:academia/features/auth/cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sliver_tools/sliver_tools.dart';

class UserSelectionPage extends StatefulWidget {
  const UserSelectionPage({super.key});

  @override
  State<UserSelectionPage> createState() => _UserSelectionPageState();
}

class _UserSelectionPageState extends State<UserSelectionPage> {
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
            builder: (context, state) {
              final List<UserData> users =
                  (state as AuthCachedUsersRetrieved).cachedUsers;

              return SliverList.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: () {},
                    leading: const CircleAvatar(),
                    title: Text(
                      users[index].username,
                    ),
                    subtitle: const Text("The user bio will appear here"),
                    trailing: const Icon(Bootstrap.newspaper),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
