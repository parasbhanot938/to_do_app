import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_app/bloc/login/login_bloc.dart';
import 'package:to_do_app/bloc/signup/signup_bloc.dart';
import 'package:to_do_app/bloc/splash/splash_bloc.dart';
import 'package:to_do_app/bloc/todo/todo_bloc.dart';
import 'package:to_do_app/constants/app_colors.dart';
import 'package:to_do_app/data/auth_provider.dart';
import 'package:to_do_app/data/auth_repo.dart';

import 'package:to_do_app/data/fetch_todo_provider.dart';
import 'package:to_do_app/data/fetch_todo_repo.dart';
import 'package:to_do_app/model/todo_model.dart';
import 'package:to_do_app/ui/add_todo_screen.dart';
import 'dart:io';

import 'package:to_do_app/ui/splash_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox<List<TodoModel>>('todo');

  Hive.registerAdapter(TodoModelAdapter());

  runApp(MultiRepositoryProvider(providers: [
    RepositoryProvider(
      lazy: false,
      create: (context) => FetchTodoRepo(),
    ),
    RepositoryProvider(
        lazy: false,
        create: (context) =>
            FetchTodoProvider(fetchTodoRepo: context.read<FetchTodoRepo>())),
    RepositoryProvider(
      lazy: false,
      create: (context) => AuthRepo(),
    ),
    RepositoryProvider(
      lazy: false,
      create: (context) => AuthRepoProvider(authRepo: context.read<AuthRepo>()),
    ),
    MultiBlocProvider(providers: [
      BlocProvider(
        lazy: false,
        create: (BuildContext context) {
          return TodoBloc(context.read<FetchTodoProvider>(),context.read<AuthRepoProvider>());
        },
      ),
      BlocProvider(
        lazy: false,
        create: (context) => SplashBloc(authRepoProvider: context.read<AuthRepoProvider>()),
      ),
      BlocProvider(
        lazy: false,
        create: (context) => LoginBloc(authRepoProvider: context.read<AuthRepoProvider>()),
      ),
      BlocProvider(
        lazy: false,
        create: (context) => SignupBloc(authRepoProvider: context.read<AuthRepoProvider>()),
      )
    ], child: const SplashScreen()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.bgColor,
          // Set Poppins font as the default font family
          fontFamily: 'Poppins',
          // primarySwatch: AppColors.appColor,
        ),
        home: SplashScreen());
  }
}
