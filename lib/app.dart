import 'package:academia/config/config.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/features.dart';
import 'package:academia/features/referals/bloc/referral_cubit.dart';
import 'package:academia/utils/router/router.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

class Academia extends StatelessWidget {
  const Academia({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    /// Initialize messaging and push notification

    // Inject the application database
    GetIt.instance.registerSingletonIfAbsent<AppDatabase>(
      () => AppDatabase(),
      instanceName: "cacheDB",
    );
    final flavor = GetIt.instance.get<FlavorConfig>();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => NotificationCubit()),
        BlocProvider(create: (_) => CourseCubit()),
        BlocProvider(create: (_) => ProfileCubit()),
        BlocProvider(create: (_) => AttendanceBloc()),
        BlocProvider(create: (_) => InAppUpdateCubit()),
        BlocProvider(create: (_) => ExamBloc()),
        BlocProvider(create: (_) => ReferralCubit()),
      ],
      child: DynamicColorBuilder(
        builder: (lightscheme, darkscheme) => MaterialApp.router(
          title: flavor.flavor.toString(),
          routerConfig: AcademiaRouter.router,
          theme: ThemeData(
            colorSchemeSeed: Colors.orange,
            brightness: Brightness.dark,
            useMaterial3: true,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
            colorSchemeSeed: Colors.orange,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
        ),
      ),
    );
  }
}
