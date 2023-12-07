import 'dart:async';

import 'package:creed_gpt/features/splash/screens/splash_screen.dart';
import 'package:creed_gpt/theme/spectrum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/auth_controller.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  static const routeName = '/sign-up';
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> executeFunction() async {
    Completer<void> completer = Completer<void>();
    createUserWithEmailAndPassword();
    await Future.delayed(const Duration(seconds: 3));
    completer.complete();
    return completer.future;
  }

  void createUserWithEmailAndPassword() {
    ref.read(authControllerProvider.notifier).createUserWithEmail(
          context,
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
  }

  void signUpWithGoogle() {
    ref.read(authControllerProvider.notifier).signUserUp(context);
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: Spectrum.whiteColor,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome back',
                    style: TextStyle(
                        fontSize: 25,
                        color: Spectrum.blackColor2,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: 300,
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        labelText: 'Email Address',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Spectrum.blackColor, width: 1.2),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Spectrum.greenColor, width: 1.2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: 300,
                    alignment: Alignment.center,
                    child: TextFormField(
                      controller: _passwordController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Password ',
                        labelText: 'Password',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Spectrum.blackColor, width: 1.2),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Spectrum.greenColor, width: 1.2)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      executeFunction().then(
                        (value) => Navigator.of(context)
                            .pushReplacementNamed(SplashScreen.routeName),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      minimumSize: const Size(300, 50),
                      backgroundColor: Spectrum.greenColor,
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text(
                            'Sign  Up',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(text: 'Already have an account? '),
                        TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: Spectrum.greenColor,
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(text: '----------------  '),
                        TextSpan(
                          text: 'OR',
                          style: TextStyle(),
                        ),
                        TextSpan(
                          text: ' ------------------',
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton.icon(
                          icon: const Icon(Icons.golf_course),
                          label: const Text(
                            'Continue With Google',
                            style: TextStyle(
                              fontSize: 16,
                              color: Spectrum.blackColor,
                            ),
                          ),
                          onPressed: signUpWithGoogle,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            minimumSize: const Size(300, 50),
                            backgroundColor: Colors.white,
                            // foregroundColor: Colors.white,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
