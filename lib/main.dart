import 'package:academia/app.dart';
import 'package:academia/database/database.dart';
import 'package:academia/features/auth/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();

  final db = AppDatabase();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(db),
        ),
      ],
      child: const Academia(),
    ),
  );
}
