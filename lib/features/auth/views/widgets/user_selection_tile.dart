import 'package:academia/database/database.dart';
import 'package:academia/features/auth/cubit/auth_cubit.dart';
import 'package:academia/features/auth/cubit/auth_states.dart';
import 'package:academia/features/home/views/layout.dart';
import 'package:academia/utils/router/router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

class UserSelectionTile extends StatefulWidget {
  const UserSelectionTile({
    super.key,
    required this.user,
  });

  final UserData user;

  @override
  State<UserSelectionTile> createState() => _UserSelectionTileState();
}

class _UserSelectionTileState extends State<UserSelectionTile> {
  late AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

  UserProfileData? profile;
  UserCredentialData? creds;

  void _showMessageDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text("ok"),
          )
        ],
      ),
    );
  }

  Future<UserProfileData?> _fetchUserProfile(UserData user) async {
    return await authCubit.fetchUserProfile(user);
  }

  Future<UserCredentialData?> _fetchUserCredentials(UserData user) async {
    final result = await authCubit.fetchUserCredsFromCache(user);
    return result.fold((l) {
      _showMessageDialog("Error", l);
      return null;
    }, (r) {
      return r;
    });
  }

  Future<void> _loadCachedData() async {
    creds = await _fetchUserCredentials(widget.user);
    profile = await _fetchUserProfile(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadCachedData(),
        builder: (context, snapshot) {
          return Skeletonizer(
            enabled: snapshot.connectionState != ConnectionState.done,
            child: ListTile(
              onTap: () async {
                final result = await authCubit.authenticate(creds!);
                result.fold((l) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(l),
                  ));
                }, (r) {
                  if (!context.mounted) return;
                  context.pop();
                  GoRouter.of(context).pushReplacementNamed(
                    AcademiaRouter.home,
                  );
                });
              },
              title: Text("@${widget.user.username}"),
              leading: (profile?.profilePictureUrl) != null
                  ? CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          profile!.profilePictureUrl!),
                    )
                  : const CircleAvatar(
                      child: Icon(Bootstrap.person),
                    ),
              subtitle:
                  BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
                if (state is AuthLoadingState) {
                  return const LinearProgressIndicator();
                }
                return Text(
                  profile?.bio ?? "No bio yet",
                );
              }),
              trailing: const Icon(Bootstrap.arrow_right),
            ),
          );
        });
  }
}
