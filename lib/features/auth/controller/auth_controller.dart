// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:creed_gpt/features/auth/repository/auth_repository.dart';

import '../../../core/utils.dart';
import '../../../models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authStateChangedProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChanged;
});

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  );
});

class AuthController extends StateNotifier<bool> {
  final AuthRepistory authRepository;
  final Ref ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  }) : super(false);

  Stream<User?> get authStateChanged => authRepository.authStateChanged;

  Stream<UserModel> getUserData() {
    return authRepository.getUserData();
  }

  void signUserUp(BuildContext context) async {
    state = true;
    final user = await authRepository.signUserUp();
    state = false;

    user.fold((l) => showSnackBar(context, l.message),
        (r) => ref.read(userProvider.notifier).update((state) => r));
  }

  void signWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    state = true;
    final user = await authRepository.signWithEmailAndPassword(email, password);
    state = false;
    user.fold((l) => showSnackBar(context, l.message),
        (r) => ref.read(userProvider.notifier).update((state) => r));
  }

  void createUserWithEmail(
      BuildContext context, String email, String password) async {
    state = true;
    final user = await authRepository.createUserWithEmail(email, password);
    state = false;
    user.fold((l) => showSnackBar(context, l.message),
        (r) => ref.read(userProvider.notifier).update((state) => r));
  }

  googleSignOut(BuildContext context) async {
    state = true;
    final user = await authRepository.googleSignOut();
    state = false;
    user.fold((l) {
      debugPrint(l.message);
      return showSnackBar(context, l.message);
    }, (r) => showSnackBar(context, 'User Signed Out...'));
  }
}
