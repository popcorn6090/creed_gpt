import 'package:creed_gpt/features/auth/controller/auth_controller.dart';
import 'package:creed_gpt/features/auth/screens/sign_up_splash_screen.dart';
import 'package:creed_gpt/features/splash/screens/splash_screen.dart';
import 'package:creed_gpt/firebase_options.dart';
import 'package:creed_gpt/models/user_model.dart';
import 'package:creed_gpt/router.dart';
import 'package:creed_gpt/theme/spectrum.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  UserModel? userModel;

  getData() async {
    userModel =
        await ref.watch(authControllerProvider.notifier).getUserData().first;
    ref.read(userProvider.notifier).update((state) => userModel);
  }

  Widget navigateToChatScreen() {
    getData();
    if (userModel == null) {
      return const SignUpSplashScreen();
    }

    return const SplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangedProvider).when(data: (data) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Creed Gpt',
        theme: Spectrum.lightMode,
        onGenerateRoute: (settings) => systemRoutes(settings),
        home:
            data != null ? navigateToChatScreen() : const SignUpSplashScreen(),
      );
    }, error: (error, trace) {
      return Center(
        child: Text(error.toString()),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
