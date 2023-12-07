import 'package:creed_gpt/features/auth/screens/sign_in_screen.dart';
import 'package:creed_gpt/features/auth/screens/sign_up_screen.dart';
import 'package:creed_gpt/features/auth/screens/sign_up_splash_screen.dart';
import 'package:creed_gpt/features/splash/screens/decoy_screen.dart';
import 'package:creed_gpt/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> systemRoutes(RouteSettings settings) {
  switch (settings.name) {
    case SignInScreen.routeName:
      return MaterialPageRoute(builder: (ctx) => const SignInScreen());
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (ctx) => const SplashScreen());
    case SignUpScreen.routeName:
      return MaterialPageRoute(builder: (ctx) => const SignUpScreen());
    case DecoyScreen.routeName:
      return MaterialPageRoute(builder: (ctx) => const DecoyScreen());
    default:
      return MaterialPageRoute(builder: (ctx) => const SignUpSplashScreen());
  }
}
