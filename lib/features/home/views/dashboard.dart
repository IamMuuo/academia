import 'dart:typed_data';
import 'package:academia/core/user/models/user_role.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/home/views/widget/course_dashboard_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/parse_route.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:vibration/vibration.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late Future<List<UserRole>?> roleresult;
  late Future<bool> notify;
  @override
  void initState() {
    super.initState();
    roleresult = BlocProvider.of<AuthBloc>(context).fetchUserRole(
      (BlocProvider.of<AuthBloc>(context).state as AuthenticatedState).user.id,
    );

    BlocProvider.of<NotificationCubit>(context)
        .hasNotificationAccess()
        .then((val) {
      if (!context.mounted || val) return;
      showModalBottomSheet(
        context: context,
        builder: (context) => EnableNotificationsBanner(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: FutureBuilder(
                future: roleresult,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final ok = snapshot.data!.firstWhereOrNull(
                      (elem) =>
                          elem.roleName == "admin" || elem.roleName == "usher",
                    );
                    if (ok == null) return SizedBox();
                    return IconButton(
                      onPressed: () async {
                        context.pushNamed("chapel-attendance");
                        if (await Vibration.hasVibrator()) {
                          await Vibration.vibrate(
                            duration: 32,
                            sharpness: 250,
                          );
                        }
                      },
                      icon: Icon(Clarity.qr_code_line),
                    );
                  }
                  return SizedBox();
                }),
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "assets/images/diversity.jpg",
                fit: BoxFit.cover,
              ),
              title: Text("Academia").animate(delay: 250.ms).moveY(
                    curve: Curves.easeInCubic,
                    duration: 1000.ms,
                    begin: -20,
                    end: 0,
                  ),
            ),
            actions: [
              // CircleAvatar(
              //   backgroundColor: Colors.black,
              //   child: IconButton(
              //     onPressed: () async {
              //       if (await Vibration.hasVibrator()) {
              //         await Vibration.vibrate(
              //           duration: 32,
              //           sharpness: 250,
              //         );
              //       }
              //       if (!context.mounted) return;
              //
              //       context.pushNamed("memberships");
              //     },
              //     icon: Icon(
              //       Clarity.id_badge_line,
              //       color: Colors.white,
              //     ),
              //   ),
              // ).animate().shake(duration: 2000.ms),
              IconButton(
                onPressed: () {
                  context.goNamed("profile");
                },
                icon: BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (stateA, stateB) {
                    if (stateB is AuthenticatedState) return true;
                    return false;
                  },
                  builder: (context, state) => CircleAvatar(
                    backgroundImage: MemoryImage(
                      (state as AuthenticatedState).user.picture ??
                          Uint8List(0),
                    ),
                  ),
                ),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(4),
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                color: Colors.green[400],
                child: Padding(
                  padding: EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      Text(
                        "New app migration coming soon",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        "In the coming days, we’ll be migrating users to a brand-new app packed with exciting new features that you've all been requesting.\nKeep an eye out for our beta invitation—you’ll get the chance to test the new app early and share your feedback!",
                      )
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(
                  curve: Curves.easeIn,
                ),
          ),

          SliverPadding(
            padding: EdgeInsets.all(12),
            sliver: CourseDashboardWidget(),
          ),

          SliverPadding(
            padding: EdgeInsets.all(12),
            sliver: SliverPinnedHeader(
              child: Container(
                color: Theme.of(context).colorScheme.surface,
                child: Text(
                  "Quick Essentials",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
          //
          SliverPadding(
            padding: EdgeInsets.all(12),
            sliver: MultiSliver(children: [
              PerformanceReportHomeTile(
                metricType: PerformanceMetricType.audit,
                title: "Audit",
                bgColor: Colors.orange,
                icon: Text(
                  "❤️‍🩹",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 8),
              FeesHomeCard(),
              SizedBox(height: 8),
            ]),
          ),
          // courses
          SliverToBoxAdapter(
            child: Text(
              "© ${DateTime.now().year} Academia All Rights Reserved",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
