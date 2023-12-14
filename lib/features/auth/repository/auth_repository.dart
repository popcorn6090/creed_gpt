// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:creed_gpt/core/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/typedef.dart';
import '../../../models/user_model.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepistory(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class AuthRepistory {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepistory({
    required this.auth,
    required this.firestore,
  });

  Stream<User?> get authStateChanged => auth.authStateChanges();

  Stream<UserModel> getUserData() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .map(
            (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  FutureEither<UserModel> createUserWithEmail(
      String email, String password) async {
    try {
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      UserModel userModel;
      if (user.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
          name: user.user!.displayName ?? '',
          profilePic: user.user!.photoURL ?? '',
          uid: user.user!.uid,
          limit: 0,
        );

        await firestore.collection('users').doc(auth.currentUser!.uid).set(
              userModel.toMap(),
            );
      } else {
        userModel = await getUserData().first;
      }

      return right(userModel);
    } on FirebaseException catch (e) {
      debugPrint(e.message!);
      throw e.message!;
    } catch (e) {
      debugPrint(e.toString());
      return left(Failure(message: e.toString()));
    }
  }

  FutureEither<UserModel> signWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      UserModel userModel;
      userModel = await getUserData().first;

      return right(userModel);
    } on FirebaseException catch (e) {
      debugPrint(e.message!);
      throw e.message!;
    } catch (e) {
      debugPrint(e.toString());
      return left(Failure(message: e.toString()));
    }
  }

  // FutureEither<UserModel> signUserUp() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: (await googleUser?.authentication)?.accessToken,
  //       idToken: (await googleUser?.authentication)?.idToken,
  //     );

  //     UserCredential userCredential =
  //         await auth.signInWithCredential(credential);

  //     UserModel userModel;

  //     if (userCredential.additionalUserInfo!.isNewUser) {
  //       userModel = UserModel(
  //         name: userCredential.user!.displayName ?? '',
  //         profilePic: userCredential.user!.photoURL ?? '',
  //         uid: userCredential.user!.uid,
  //         limit: 0,
  //       );

  //       await firestore
  //           .collection('users')
  //           .doc(userCredential.user!.uid)
  //           .set(userModel.toMap());
  //     } else {
  //       userModel = await getUserData().first;
  //     }
  //     return right(userModel);
  //   } on FirebaseException catch (e) {
  //     throw e.message!;
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     return left(Failure(message: e.toString()));
  //   }
  // }

  FutureVoid googleSignOut() async {
    try {
      return right(await auth.signOut());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}
