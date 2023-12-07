import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;
  final String profilePic;
  final String uid;
  final bool isAuthenticated;
  final double limit;
  UserModel({
    required this.name,
    required this.profilePic,
    required this.uid,
    required this.isAuthenticated,
    required this.limit,
  });

  UserModel copyWith({
    String? name,
    String? profilePic,
    String? uid,
    bool? isAuthenticated,
    double? limit,
  }) {
    return UserModel(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      limit: limit ?? this.limit,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'profilePic': profilePic,
      'uid': uid,
      'isAuthenticated': isAuthenticated,
      'limit': limit,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      uid: map['uid'] as String,
      isAuthenticated: map['isAuthenticated'] as bool,
      limit: map['limit'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, profilePic: $profilePic, uid: $uid, isAuthenticated: $isAuthenticated, limit: $limit)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.profilePic == profilePic &&
        other.uid == uid &&
        other.isAuthenticated == isAuthenticated &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        profilePic.hashCode ^
        uid.hashCode ^
        isAuthenticated.hashCode ^
        limit.hashCode;
  }
}
