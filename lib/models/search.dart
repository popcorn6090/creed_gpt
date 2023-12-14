import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Search {
  final String id;
  final String response;
  final String messageType;
  final String createdAt;
  Search({
    required this.id,
    required this.response,
    required this.messageType,
    required this.createdAt,
  });

  Search copyWith({
    String? id,
    String? response,
    String? messageType,
    String? createdAt,
  }) {
    return Search(
      id: id ?? this.id,
      response: response ?? this.response,
      messageType: messageType ?? this.messageType,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_id': id,
      'response': response,
      'messageType': messageType,
      'createdAt': createdAt,
    };
  }

  factory Search.fromMap(Map<String, dynamic> map) {
    return Search(
      id: map['_id'] as String,
      response: map['response'] as String,
      messageType: map['messageType'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  Search.fromJson(Map<String, dynamic> source)
      : id = source['_id'],
        response = source['response'],
        messageType = source['messageType'],
        createdAt = source['date'];

  // factory Search.fromJson(String source) =>
  //     Search.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Search(id: $id, response: $response, messageType: $messageType, createdAt: $createdAt)';
  }

  @override
  bool operator ==(covariant Search other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.response == response &&
        other.messageType == messageType &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        response.hashCode ^
        messageType.hashCode ^
        createdAt.hashCode;
  }
}
