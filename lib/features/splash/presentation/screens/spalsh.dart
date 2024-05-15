import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:untitled/features/login/presentation/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      duration: 3000,
      splash: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Welcome",
            textDirection: TextDirection.rtl,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
      nextScreen: const LoginScreen(),
      splashTransition: SplashTransition.scaleTransition,
      // backgroundColor: kMainColor,
    );
  }

}
