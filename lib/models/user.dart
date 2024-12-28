import 'dart:convert';

class User {
  String id;
  String username;
  String email;
  String firstName;
  String lastName;
  String? imageUrl;
  bool isAdmin;
  int followingCount;
  int followerCount;
  DateTime createdAt;
  DateTime lastUpdatedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.imageUrl,
    required this.isAdmin,
    required this.followingCount,
    required this.followerCount,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? imageUrl,
    bool? isAdmin,
    int? followingCount,
    int? followerCount,
    DateTime? createdAt,
    DateTime? lastUpdatedAt,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        imageUrl: imageUrl ?? this.imageUrl,
        isAdmin: isAdmin ?? this.isAdmin,
        followingCount: followingCount ?? this.followingCount,
        followerCount: followerCount ?? this.followerCount,
        createdAt: createdAt ?? this.createdAt,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        email: json["email"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        imageUrl: json["imageUrl"],
        isAdmin: json["isAdmin"],
        followingCount: json["followingCount"],
        followerCount: json["followerCount"],
        createdAt: DateTime.parse(json["createdAt"]),
        lastUpdatedAt: DateTime.parse(json["lastUpdatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
        "imageUrl": imageUrl,
        "isAdmin": isAdmin,
        "followingCount": followingCount,
        "followerCount": followerCount,
        "createdAt": createdAt.toIso8601String(),
        "lastUpdatedAt": lastUpdatedAt.toIso8601String(),
      };
}

class UserLoginDto {
  String username;
  String password;

  UserLoginDto({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() => {
        "username": username,
        "password": password,
      };
}

class UserRegisterDto {
  String username;
  String password;
  String email;
  String firstName;
  String lastName;

  UserRegisterDto({
    required this.username,
    required this.password,
    required this.email,
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toMap() => {
        "username": username,
        "password": password,
        "email": email,
        "firstName": firstName,
        "lastName": lastName,
      };
}
