import 'package:creed_gpt/features/auth/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/commons/type_writer.dart';
import '../../../../theme/spectrum.dart';
import '../sign_in_screen.dart';

class MobileSignUpSplashScreen extends ConsumerStatefulWidget {
  const MobileSignUpSplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MobileSignUpSplashScreenState();
}

class _MobileSignUpSplashScreenState
    extends ConsumerState<MobileSignUpSplashScreen> {
  void navigateToSignInScreen() {
    Navigator.of(context).pushNamed(SignInScreen.routeName);
  }

  void navigateToSignUpScreen() {
    Navigator.of(context).pushNamed(SignUpScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Pallete.signUpBackground,
      body: Column(children: [
        Container(
          color: Spectrum.signUpBackground,
          height: 450,
          //  width: 800,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'L\'argent',
                  style: TextStyle(fontSize: 32),
                ),
                const SizedBox(
                  height: 50,
                ),
                const TypeWriter(
                  speed: Duration(seconds: 4),
                  text: 'Ask Me Anything and I will do it.',
                  style: TextStyle(color: Spectrum.purpleColor, fontSize: 30),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            height: 450,
            //   color: Spectrum.blackColor2,
            alignment: Alignment.center,
            child: Column(children: [
              const Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: navigateToSignInScreen,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: navigateToSignUpScreen,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text(
                      'Sign  Up',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              )
            ]),
          ),
        ),
      ]),
    );
  }
}
