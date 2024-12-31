import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';
import 'package:academia/utils/router/router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ProfilePageMobile extends StatefulWidget {
  const ProfilePageMobile({super.key});

  @override
  State<ProfilePageMobile> createState() => _ProfilePageMobileState();
}

class _ProfilePageMobileState extends State<ProfilePageMobile> {
  late UserData user;
  late AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
  late ProfileCubit profileCubit = BlocProvider.of<ProfileCubit>(context);

  @override
  void initState() {
    super.initState();
    if (authCubit.state is AuthenticatedState) {
      user = (authCubit.state as AuthenticatedState).user;
      profileCubit.fetchUserProfileFromCache(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          final localAuth = (authCubit.state as AuthenticatedState).localAuth;
          if (localAuth) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Please check your internet connection and try again!",
                ),
              ),
            );
            return;
          }
          final response = await profileCubit.fetchUserProfileFromRemote(user);
          response.fold((error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error)),
            );
          }, (profile) {
            setState(() {});
          });
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Bootstrap.pencil),
                ),
                IconButton(
                  onPressed: () {
                    HapticFeedback.heavyImpact().then((val) {
                      if (!context.mounted) return;
                      GoRouter.of(context).pushNamed(AcademiaRouter.auth);
                    });
                  },
                  icon: const Icon(Bootstrap.person_add),
                )
              ],
            ),
            SliverPinnedHeader(
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(12),
                child: Row(
                  spacing: 12,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: BlocBuilder<ProfileCubit, ProfileState>(
                          buildWhen: (previous, current) {
                            if (current is ProfileLoadingState) {
                              return true;
                            } else if (current is ProfileLoadedState) {
                              return true;
                            }
                            return false;
                          },
                          builder: (context, state) {
                            if (state is ProfileLoadingState) {
                              return const CircularProgressIndicator.adaptive();
                            }
                            final profile =
                                (state as ProfileLoadedState).userProfiles;

                            return CachedNetworkImage(
                              imageUrl: profile.profilePictureUrl ?? "",
                              fit: BoxFit.fill,
                              errorWidget: (context, error, message) {
                                return Image.asset(
                                  "assets/icons/academia_prod.png",
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 2,
                        children: [
                          Text(
                            "${user.firstname} ${user.othernames}",
                            style: Theme.of(context).textTheme.headlineSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text("Preview my school ID"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(12),
              sliver: SliverClip(
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (profileCubit.state is! ProfileLoadedState) {
                      return SliverFillRemaining(
                        child: Skeletonizer(
                          enabled: true,
                          child: ListView.builder(
                              itemCount: 8,
                              itemBuilder: (context, index) => Card(
                                    elevation: 0,
                                    shape: index == 0
                                        ? const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(12),
                                            ),
                                          )
                                        : index == 7
                                            ? const RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  bottom: Radius.circular(12),
                                                ),
                                              )
                                            : const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.zero)),
                                    child: const ListTile(),
                                  )),
                        ),
                      );
                    }
                    final profile = (state as ProfileLoadedState).userProfiles;
                    return MultiSliver(
                      pushPinnedChildren: true,
                      children: [
                        SliverPinnedHeader(
                          child: Container(
                            color: Theme.of(context).colorScheme.surface,
                            child: Text(
                              "Student information",
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 2),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          child: ListTile(
                            leading: const Icon(Bootstrap.hash),
                            title: const Text("Admission Number"),
                            subtitle: Text("${profile.admissionNumber}"),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 2),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.zero,
                            ),
                          ),
                          child: ListTile(
                            leading: const Icon(Bootstrap.at),
                            title: const Text("Academia Username"),
                            subtitle: Text("@${user.username}"),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 2),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.zero,
                            ),
                          ),
                          child: ListTile(
                            leading: const Icon(Bootstrap.chat_dots),
                            title: const Text("Bio"),
                            subtitle: Text(
                              "${profile.bio}",
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 2),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero)),
                          child: ListTile(
                            leading: const Icon(Bootstrap.gender_ambiguous),
                            title: const Text("Gender"),
                            subtitle: Text(user.gender),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 2),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero)),
                          child: ListTile(
                            leading: const Icon(Icons.card_giftcard),
                            title: const Text("National ID"),
                            subtitle: Text(user.nationalId),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 2),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero)),
                          child: ListTile(
                            leading: const Icon(Bootstrap.phone),
                            title: const Text("Phone"),
                            subtitle: Text(user.phone),
                          ),
                        ),
                        Card(
                          elevation: 0,
                          margin: const EdgeInsets.only(bottom: 2),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero)),
                          child: ListTile(
                            leading: const Icon(Bootstrap.envelope),
                            title: const Text("Email"),
                            subtitle: Text(user.email ?? "unknown"),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12),
                            ),
                          ),
                          child: ListTile(
                            leading: const Icon(Bootstrap.house_heart),
                            title: const Text("Campus"),
                            subtitle: Text(profile.campus),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
