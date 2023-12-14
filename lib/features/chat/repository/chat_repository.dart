// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creed_gpt/core/failure.dart';
import 'package:creed_gpt/core/typedef.dart';
import 'package:creed_gpt/models/question.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

import '../../../models/search.dart';
import '../../../models/user_model.dart';

final chatRepositoryProvider = Provider((ref) {
  return ChatRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

class ChatRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  ChatRepository({
    required this.auth,
    required this.firestore,
  });

  FutureEither<Search> getSearchResults(String askedQuestion) async {
    try {
      final res = await http
          .get(Uri.parse('http://localhost:3000/search?name=$askedQuestion'));
      final decodedResults = jsonDecode(res.body)["matchingResults"] as List;

      if (decodedResults.isEmpty) {
        throw Exception(
            'Í do not have any clue what happened. Try again later.');
      }

      print(decodedResults);
      final finalResults =
          decodedResults.map((e) => Search.fromJson(e)).toList()[0];

      List<String> existingQuestions = [];
      List<Map<String, dynamic>> existingAnswers = [];

      await firestore
          .collection('search')
          .doc(auth.currentUser!.uid)
          .collection('userSearches')
          .doc(auth.currentUser!.uid)
          .get()
          .then((doc) async {
        if (doc.exists) {
          Question question = Question(
            id: doc['id'],
            question: List<String>.from(doc['question']),
            answer: List<Map<String, dynamic>>.from(doc['answer']),
            createdAt: doc['createdAt'],
          );

          existingQuestions = question.question;
          existingAnswers = question.answer;

          List<String> updatedQuestions = existingQuestions..add(askedQuestion);

          Map<String, dynamic> answerToBeAdded = {
            'value': finalResults.response,
            'type': finalResults.messageType
          };
          List<Map<String, dynamic>> updatedAnswers = existingAnswers
            ..add(answerToBeAdded);

          await firestore
              .collection('search')
              .doc(auth.currentUser!.uid)
              .collection('userSearches')
              .doc(auth.currentUser!.uid)
              .update({'answer': updatedAnswers, 'question': updatedQuestions});
        } else {
          Map<String, dynamic> answerToBeAdded = {
            'value': finalResults.response,
            'type': finalResults.messageType
          };

          Question question = Question(
            id: finalResults.id,
            question: [askedQuestion],
            answer: [answerToBeAdded],
            createdAt: finalResults.createdAt,
          );

          await firestore
              .collection('search')
              .doc(auth.currentUser!.uid)
              .collection('userSearches')
              .doc(auth.currentUser!.uid)
              .set(question.toMap());
        }
      });

      return right(finalResults);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  Stream<Question> getAllQuestionsAndAnswers(Ref ref) {
    return firestore
        .collection('search')
        .doc(auth.currentUser!.uid)
        .collection('userSearches')
        .doc(auth.currentUser!.uid)
        .snapshots()
        .map((event) {
      if (!event.exists || event.data() == null) {
        return Question(id: 'id', question: [], answer: [], createdAt: '');
      }

      var data = event.data()!;

      List<String> question = List<String>.from(data['question'] ?? []);
      List<Map<String, dynamic>> answer =
          List<Map<String, dynamic>>.from(data['answer'] ?? []);

      return Question(
        id: data['id'] ?? '',
        question: question,
        answer: answer,
        createdAt: data['createdAt'],
      );
    });
  }

  FutureEither<UserModel> premiumLimit(UserModel user) async {
    try {
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update({'limit': user.limit + 1});

      return right(user);
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  updateLimit(UserModel user) {
    try {
      if (user.limit > 10) {
        Timer(const Duration(hours: 24), () async {
          await firestore
              .collection('users')
              .doc(auth.currentUser!.uid)
              .update({'limit': 0});
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
