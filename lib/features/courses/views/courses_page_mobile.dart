import 'package:academia/features/features.dart';
import 'package:academia/utils/router/router.dart';
import 'package:academia/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CoursesPageMobile extends StatefulWidget {
  const CoursesPageMobile({super.key});

  @override
  State<CoursesPageMobile> createState() => _CoursesPageMobileState();
}

class _CoursesPageMobileState extends State<CoursesPageMobile> {
  late CourseCubit courseCubit = BlocProvider.of<CourseCubit>(context);
  late AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);

  @override
  void initState() {
    courseCubit.fetchCachedCourses(
      (authCubit.state as AuthenticatedState).user,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await courseCubit.syncCourses(
            (authCubit.state as AuthenticatedState).user,
          );
        },
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              pinned: true,
              floating: true,
              snap: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  "Courses",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontFamily: GoogleFonts.libreBaskerville().fontFamily,
                      ),
                ),
              ),
            ),
            BlocBuilder<CourseCubit, CourseState>(builder: (context, state) {
              if (state is CourseStateLoaded) {
                if (state.courses.isNotEmpty) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    sliver: SliverList.separated(
                      itemBuilder: (context, index) {
                        final course = state.courses[index];
                        return ListTile(
                          onTap: () => context.pushNamed(
                            AcademiaRouter.courseView,
                            extra: course,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: course.color == null
                                ? null
                                : Color(course.color!),
                          ),
                          title: Text("${course.unit} ${course.section}"),
                          subtitle: Text(
                            "${course.room} *  ${course.period} * ${course.lecturer.capitalize()}",
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(),
                      itemCount: state.courses.length,
                    ),
                  );
                }

                return const SliverFillRemaining(
                  // TODO: erick add an illustration or animation
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("You have no courses yet, please pull to refresh"),
                    ],
                  ),
                );
              }
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverList.separated(
                  itemCount: 8,
                  itemBuilder: (context, index) => const Skeletonizer(
                    enabled: true,
                    child: ListTile(
                      leading: CircleAvatar(),
                      title: Text("Some Couse"),
                      subtitle: Text("PLAB * 10:00 - 13:00 * Awesome Lecturer"),
                    ),
                  ),
                  separatorBuilder: (context, index) => const SizedBox(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
