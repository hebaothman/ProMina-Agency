import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled/config/routes/app_routes.dart';
import 'package:untitled/features/login/login_injection_container.dart';
import 'package:untitled/features/login/presentation/cubit/login_cubit.dart';
import 'package:untitled/injection_container.dart';

final sl = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loginDependencyInjectionInit();
  await dependencyInjectionInit();//For initializing network info and shared preferences
  runApp(
    BlocProvider<LoginCubit>(
      create: (context) => sl<LoginCubit>(),
      child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Tajawal', useMaterial3: false),
      initialRoute: '/',
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}