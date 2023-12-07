import 'package:flutter/material.dart';

class DecoyScreen extends StatelessWidget {
  static const routeName = '/decoy-screen';
  const DecoyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Let\'s get started.',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
