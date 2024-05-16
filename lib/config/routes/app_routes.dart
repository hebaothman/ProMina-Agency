import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/core/utils/app_strings.dart';
import 'package:untitled/core/utils/constants.dart';
import 'package:untitled/features/gallery/presentation/cubit/upload_cubit.dart';
import 'package:untitled/features/gallery/presentation/screens/gallery.dart';
import 'package:untitled/features/login/presentation/cubit/login_cubit.dart';
import 'package:untitled/features/login/presentation/screens/login.dart';
import 'package:untitled/features/splash/presentation/screens/spalsh.dart';
import 'package:untitled/main.dart';

class Routes {
  static const String initialRoute = '/';
  static const String loginRoute = '/login';
  static const String galleryRoute = '/gallery';

}

class AppRoute {
  static Route? onGenerateRoute(RouteSettings settings){
    switch(settings.name){
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (context) => BlocProvider<LoginCubit>(
          create: (context) => sl<LoginCubit>(),
          child: const LoginScreen()
        ),);
      case Routes.galleryRoute:
        final args = settings.arguments as UserNameArguments;
        return MaterialPageRoute(builder: (context) => BlocProvider<UploadCubit>(
          create: (context) => sl<UploadCubit>(),
          child: GalleryScreen(userToken: args.userToken,)
        ));
      default :
        return _errorRoute();
    }
  }
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context){
      return Scaffold(
        appBar: AppBar(
          title: Constants.normalText(context: context, text: AppStrings.error),
          centerTitle: true,
        ),
        body: Center(
          child: Constants.normalText(context: context, text: AppStrings.noRouteFound),
        ),
      );
    });
  }

}