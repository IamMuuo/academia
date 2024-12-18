import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return Future.delayed(const Duration(seconds: 10));
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Bootstrap.pencil),
                ),
                IconButton(
                  onPressed: () {},
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
                    const CircleAvatar(
                      radius: 60,
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
                    print(state.runtimeType.toString());
                    if (state is ProfileErrorState) {
                      print((state as ProfileErrorState).error);
                    }
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
                      children: [
                        Text(
                          "Some long bio here to be here",
                          overflow: TextOverflow.visible,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(Bootstrap.hash),
                            title: Text("Admission Number"),
                            subtitle: Text("21-1000"),
                          ),
                        ),
                        const Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero)),
                          child: ListTile(
                            leading: Icon(Bootstrap.hash),
                            title: Text("Admission Number"),
                            subtitle: Text("21-1000"),
                          ),
                        ),
                        const Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(12),
                            ),
                          ),
                          child: ListTile(
                            leading: Icon(Bootstrap.hash),
                            title: Text("Admission Number"),
                            subtitle: Text("21-1000"),
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
