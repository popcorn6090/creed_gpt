import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Question {
  final String id;
  final List<String> question;
  final List<Map<String, dynamic>> answer;
  final String createdAt;
  Question({
    required this.id,
    required this.question,
    required this.answer,
    required this.createdAt,
  });

  Question copyWith({
    String? id,
    List<String>? question,
    List<Map<String, dynamic>>? answer,
    String? createdAt,
  }) {
    return Question(
      id: id ?? this.id,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'answer': answer,
      'createdAt': createdAt,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as String,
      question: List<String>.from((map['question'] as List<String>)),
      answer: List<Map<String, dynamic>>.from(
        (map['answer'] as List<int>),
      ),
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Question(id: $id, question: $question, answer: $answer, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Question other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.question, question) &&
        listEquals(other.answer, answer) &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        question.hashCode ^
        answer.hashCode ^
        createdAt.hashCode;
  }
}
