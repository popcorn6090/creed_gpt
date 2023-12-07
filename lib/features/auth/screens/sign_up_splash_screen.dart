import 'package:creed_gpt/features/auth/screens/sign_in_screen.dart';
import 'package:creed_gpt/features/auth/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/commons/type_writer.dart';
import '../../../theme/spectrum.dart';

class SignUpSplashScreen extends ConsumerStatefulWidget {
  static const routeName = '/sign-up';
  const SignUpSplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpSplashScreenState();
}

class _SignUpSplashScreenState extends ConsumerState<SignUpSplashScreen> {
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
        Row(
          children: [
            Container(
              color: Spectrum.signUpBackground,
              height: size.height,
              width: 800,
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CreedGPT',
                      style: TextStyle(fontSize: 32),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                    TypeWriter(
                        speed: Duration(seconds: 4),
                        text: 'Ask Me Anything and I will do it.',
                        style: TextStyle(
                            color: Spectrum.purpleColor, fontSize: 30))
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: size.height,
                color: Spectrum.blackColor2,
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Get Started',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
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
                            const SizedBox(width: 20),
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
            ),
          ],
        )
      ]),
    );
  }
}
