import 'package:academia/constants/common.dart';
import 'package:academia/features/features.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:vibration/vibration.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageMobileState();
}

class _CoursesPageMobileState extends State<CoursesPage> {
  late CourseCubit courseCubit = BlocProvider.of<CourseCubit>(context);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await courseCubit.refreshCourses();
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              floating: true,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  "assets/images/ware-wolf.jpg",
                  fit: BoxFit.cover,
                ),
                title: Text("Courses"),
              ),
            ),

            // build
            SliverPadding(
              padding: EdgeInsets.all(12),
              sliver: BlocBuilder<CourseCubit, CourseState>(
                builder: (context, state) {
                  if (state is CourseStateError) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(state.error),
                      ),
                    );
                  }

                  if (state is CourseStateLoaded) {
                    if (state.courses.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              "assets/lotties/cooking.json",
                              repeat: !kDebugMode,
                            ),
                            Text(
                              "We couldn't load your courses right now. Try pulling down to refresh, or check your connection and try again.",
                              style: Theme.of(context).textTheme.titleSmall,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                    return SliverList.builder(
                      itemCount: state.courses.length,
                      itemBuilder: (context, index) {
                        final course = state.courses.elementAt(index);
                        return Card(
                          child: ListTile(
                            onTap: () async {
                              context.push("/course-view", extra: course);
                              if (await Vibration.hasVibrator()) {
                                await Vibration.vibrate(
                                  duration: 32,
                                  sharpness: 250,
                                );
                                if (!context.mounted) return;
                              }
                            },
                            leading: CircleAvatar(
                              backgroundColor: Color(
                                course.color ??
                                    Theme.of(context).colorScheme.primary.value,
                              ).withAlpha(100),
                            ),
                            tileColor: Color(course.color ??
                                    Theme.of(context)
                                        .colorScheme
                                        .primaryContainer
                                        .value)
                                .withAlpha(50),
                            title: Text("${course.unit} ${course.section}"),
                            subtitle: Text(
                              "${course.weekDay.title()} • ${course.room} •  ${course.period}",
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        );
                      },
                    );
                  }

                  if (state is CourseStateLoading) {
                    return SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Lottie.asset("assets/lotties/loading-bounce.json"),
                          Text(
                            "Hang on tight! Your courses are just around the corner.",
                            style: Theme.of(context).textTheme.titleLarge,
                          )
                        ],
                      ),
                    );
                  }

                  return SliverToBoxAdapter(
                    child: Text(
                      (state as CourseStateError).error,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
