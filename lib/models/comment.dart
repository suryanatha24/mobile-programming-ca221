import 'dart:convert';

class Comment {
  String id;
  String momentId;
  String creator;
  String comment;
  DateTime createdAt;

  Comment({
    required this.id,
    required this.momentId,
    required this.creator,
    required this.comment,
    required this.createdAt
  });

  Comment copyWith({
    String? id,
    String? momentId,
    String? creator,
    String? comment,
    DateTime? createdAt
  }) =>
    Comment(
      id: id ?? this.id,
      momentId: momentId ?? this.momentId,
      creator: creator ?? this.creator,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt
    );
  
  factory Comment.fromMap(Map<String, dynamic> map) => Comment(
    id: map['id'],
    momentId: map['momentId'],
    creator: map['creator'],
    comment: map['comment'],
    createdAt: DateTime.parse(map['createdAt'])
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'momentId': momentId,
    'creator': creator,
    'comment': comment,
    'createdAt': createdAt.toIso8601String()
  };

  factory Comment.fromJson(String json) => Comment.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());
}