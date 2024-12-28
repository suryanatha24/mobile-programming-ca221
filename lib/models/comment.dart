import 'dart:convert';

class Comment {
  String? id;
  String? creatorId;
  String? creatorUsername;
  String? creatorFullname;
  String momentId;
  String content;
  late DateTime createdAt;
  late DateTime lastUpdatedAt;

  Comment({
    this.id,
    this.creatorId,
    this.creatorUsername,
    this.creatorFullname,
    required this.momentId,
    required this.content,
    DateTime? createdAt,
    DateTime? lastUpdatedAt,
  }) {
    this.createdAt = createdAt ?? DateTime.now();
    this.lastUpdatedAt = lastUpdatedAt ?? DateTime.now();
  }

  Comment copyWith({
    String? id,
    String? creatorId,
    String? creatorUsername,
    String? creatorFullname,
    String? momentId,
    String? content,
    DateTime? createdAt,
    DateTime? lastUpdatedAt,
  }) =>
      Comment(
        id: id ?? this.id,
        creatorId: creatorId ?? this.creatorId,
        creatorUsername: creatorUsername ?? this.creatorUsername,
        creatorFullname: creatorFullname ?? this.creatorFullname,
        momentId: momentId ?? this.momentId,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      );

  factory Comment.fromJson(String str) => Comment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        id: json["id"],
        creatorId: json["creatorId"],
        creatorUsername: json["creatorUsername"],
        creatorFullname: json["creatorFullname"],
        momentId: json["momentId"],
        content: json["content"],
        createdAt: DateTime.parse(json["createdAt"]),
        lastUpdatedAt: DateTime.parse(json["lastUpdatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "creatorId": creatorId,
        "creatorUsername": creatorUsername,
        "creatorFullname": creatorFullname,
        "momentId": momentId,
        "content": content,
        "createdAt": createdAt.toIso8601String(),
        "lastUpdatedAt": lastUpdatedAt.toIso8601String(),
      };

  Map<String, dynamic> toDto() => {
        "content": content,
      };
}
