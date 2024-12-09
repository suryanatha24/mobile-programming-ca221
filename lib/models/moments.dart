import 'dart:convert';

class Moment {
  String id;
  DateTime momentDate;
  String creator;
  String location;
  String imageUrl;
  String caption;
  int likeCount;
  int commentCount;
  int bookmarkCount;

  Moment({
    required this.id,
    required this.momentDate,
    required this.creator,
    required this.location,
    required this.imageUrl,
    required this.caption,
    this.likeCount = 0,
    this.commentCount = 0,
    this.bookmarkCount = 0
  });
Moment copyWith({
  String? id,
  DateTime? momentDate,
  String? creator,
  String? location,
  String? imageUrl,
  String? caption,
  int? likeCount,
  int? commentCount,
  int? bookmarkCount
}) {
    return Moment(
      id: id ?? this.id,
      momentDate: momentDate ?? this.momentDate,
      creator: creator ?? this.creator,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      caption: caption ?? this.caption,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      bookmarkCount: bookmarkCount ?? this.bookmarkCount
    );
  }

  factory Moment.fromMap(Map<String, dynamic> map) {
    return Moment(
      id: map['id'],
      momentDate: DateTime.parse(map['momentDate']),
      creator: map['creator'],
      location: map['location'],
      imageUrl: map['imageUrl'],
      caption: map['caption'],
      likeCount: map['likeCount'],
      commentCount: map['commentCount'],
      bookmarkCount: map['bookmarkCount']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'momentDate': momentDate.toIso8601String(),
      'creator': creator,
      'location': location,
      'imageUrl': imageUrl,
      'caption': caption,
      'likeCount': likeCount,
      'commentCount': commentCount,
      'bookmarkCount': bookmarkCount
    };
  }

  factory Moment.fromJson(String json) => Moment.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());
}